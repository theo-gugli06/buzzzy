import * as argon2 from 'argon2';

import { BadRequestException, Injectable } from '@nestjs/common'; // BadRequestException sert a renvoyer une erreur 400, Injectable permet a NestJS d'injecter ce service ailleurs.
import { InjectRepository } from '@nestjs/typeorm'; // Permet de connecter un repository TypeORM a une entity.
import { DataSource, Repository } from 'typeorm'; // DataSource permet de lancer une transaction, Repository permet de parler a une table.

import { CreateSalonDto } from '../dto/create-salon.dto'; // DTO qui decrit les donnees attendues pour creer un salon.
import { SalonEntity } from '../entities/salon.entity'; // Entity qui represente la table SQL "salon".

import { UsersService } from '../../users/services/users.service';
import { SalonMembersService } from '../../salon-members/services/salon-members.service';

import { RoleEntity } from '../../roles/entities/role.entity'; // Entity qui represente la table SQL "role".

import { UserEntity } from '../../users/entities/user.entity';
import { SalonMemberEntity } from '../../salon-members/entities/salon-member.entity';


@Injectable() //Cette classe peut être créée et utilisée automatiquement ailleurs dans l’application
export class SalonsService {
    constructor(
        // Demande a NestJS/TypeORM de fournir le repository lie a SalonEntity.
        // Comme SalonEntity represente la table SQL "salon",
        // ce repository permettra de parler a la table "salon".
        @InjectRepository(SalonEntity)

        // salonsRepository est la variable qui contient ce repository.
        // private = utilisable seulement dans cette classe.
        // readonly = on ne remplace pas cette variable apres sa creation.
        // Repository<SalonEntity> = outil TypeORM pour chercher, creer et enregistrer des salons.
        private readonly salonsRepository: Repository<SalonEntity>,

        // Demande a NestJS/TypeORM de fournir le repository lie a RoleEntity.
        // Ce repository servira a chercher le role "owner" dans la table "role".
        @InjectRepository(RoleEntity)
        private readonly rolesRepository: Repository<RoleEntity>,


        // Service utilise pour rechercher ou creer un utilisateur.
        // Ici, il servira a creer le compte du professionnel.
        private readonly usersService: UsersService,

        // Service utilise pour creer le lien entre un user, un salon et un role.
        // Ici, il servira a rattacher le createur au salon.
        private readonly salonMembersService: SalonMembersService,

        // DataSource donne acces a la connexion TypeORM globale.
        // On l'utilisera pour lancer une transaction.
        private readonly dataSource: DataSource,

    ) { }

    async create(createSalonDto: CreateSalonDto) {
        // On nettoie les textes recus depuis le front.
        const name = createSalonDto.name.trim();
        const userEmail = createSalonDto.userEmail.trim().toLowerCase();
        const salonEmail = createSalonDto.salonEmail.trim().toLowerCase();
        const category = createSalonDto.category.trim();
        const specialty = createSalonDto.specialty.trim();
        const salonPhone = createSalonDto.salonPhone.trim();
        const address = createSalonDto.address.trim();
        const city = createSalonDto.city.trim();
        const postalCode = createSalonDto.postalCode.trim();
        const country = createSalonDto.country.trim();
        const description = createSalonDto.description?.trim();

        const accountMode = createSalonDto.accountMode.trim();

        // Donnees du compte utilisateur a creer.
        const firstname = createSalonDto.firstname?.trim();
        const lastname = createSalonDto.lastname?.trim();
        const userPhone = createSalonDto.userPhone?.trim();
        const password = createSalonDto.password.trim();
        const confirmPassword = createSalonDto.confirmPassword.trim();

        // Pr l'instant je geres seulement le cas inscription.
        if (accountMode !== 'create') {
            throw new BadRequestException(
                'Le mode de compte doit etre create pour ce parcours',
            );
        }

        // En mode inscription, les informations du compte sont obligatoires.
        if (
            !firstname ||
            !lastname ||
            !userEmail ||
            !password ||
            !confirmPassword
        ) {
            throw new BadRequestException(
                'Tous les champs du compte utilisateur doivent etre remplis',
            );
        }

        // On verifie que les deux mots de passe saisis sont identiques.
        if (password !== confirmPassword) {
            throw new BadRequestException(
                'Les mots de passe ne correspondent pas',
            );
        }

        // On verifie qu'aucun compte utilisateur n'utilise deja cet email.
        //const existingUser = await this.usersService.findByEmail(email);
        const existingUser = await this.usersService.findByEmail(userEmail);

        if (existingUser) {
            throw new BadRequestException(
                'Un compte utilisateur utilise deja cet email',
            );
        }

        // Verification metier simple avant creation.
        if (
            !name ||
            !salonEmail ||
            !category ||
            !specialty ||
            !salonPhone ||
            !address ||
            !city ||
            !postalCode ||
            !country
        ) {
            throw new BadRequestException(
                'Tous les champs obligatoires du salon doivent etre remplis',
            );
        }

        // Comme email est unique dans la table salon, on evite un doublon.
        const existingSalon = await this.salonsRepository.findOne({
            where: { email: salonEmail },
        });

        if (existingSalon) {
            throw new BadRequestException('Un salon utilise deja cet email');
        }

        // On cherche le role "owner" pour rattacher le createur au salon.
        const ownerRole = await this.rolesRepository.findOne({
            where: { name: 'owner' },
        });

        // Si le role owner n'existe pas en base, on bloque la creation.
        if (!ownerRole) {
            throw new BadRequestException('Le role owner est introuvable');
        }

        // On hash le mot de passe avant de le stocker en base.
        const hashedPassword = await argon2.hash(password);

        // les creations doivent reussir ensemble.
        // Si une creation echoue, TypeORM annulera toute la transaction.
        return this.dataSource.transaction(async (manager) => {
            // manager est fourni par TypeORM et permet de faire les insertions dans cette transaction.

            // On prepare le compte utilisateur avec le mot de passe hashe.
            const newUser = manager.create(UserEntity, {
                firstname,
                lastname,
                phone: userPhone || undefined,
                email: userEmail,
                password: hashedPassword,
            });

            // On enregistre l'utilisateur dans la transaction.
            const createdUser = await manager.save(UserEntity, newUser);

            // On prepare le salon avant de l'enregistrer.
            const newSalon = manager.create(SalonEntity, {
                name,
                description,
                category,
                specialty,
                phone: salonPhone,
                email: salonEmail,
                address,
                city,
                postalCode,
                country,
            });

            // On enregistre le salon dans la transaction.
            const createdSalon = await manager.save(SalonEntity, newSalon);

            // On prepare le lien entre le createur, le salon et le role owner.
            const newSalonMember = manager.create(SalonMemberEntity, {
                userId: createdUser.id,
                salonId: createdSalon.id,
                roleId: ownerRole.id,
            });

            // On enregistre le salonMember dans la transaction.
            const createdSalonMember = await manager.save(
                SalonMemberEntity,
                newSalonMember,
            );

            // Cette reponse est envoyee seulement si les 3 creations ont reussi.
            return {
                message: 'Compte, salon et membre salon crees avec succes',
                user: {
                    id: createdUser.id,
                    email: createdUser.email,
                    firstname: createdUser.firstname,
                    lastname: createdUser.lastname,
                },
                salon: createdSalon,
                salonMember: createdSalonMember,
            };
        });
    }
}