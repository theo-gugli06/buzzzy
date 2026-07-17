import { BadRequestException, Injectable } from '@nestjs/common'; // BadRequestException sert a renvoyer une erreur 400, Injectable permet a NestJS d'injecter ce service ailleurs.
import { InjectRepository } from '@nestjs/typeorm'; // Permet de connecter un repository TypeORM a une entity.
import { Repository } from 'typeorm'; // Type TypeORM qui donne les methodes pour parler a la BDD : findOne, create, save...

import { CreateSalonDto } from '../dto/create-salon.dto'; // DTO qui decrit les donnees attendues pour creer un salon.
import { SalonEntity } from '../entities/salon.entity'; // Entity qui represente la table SQL "salon".

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
) {}

  async create(createSalonDto: CreateSalonDto) {
    // On nettoie les textes recus depuis le front.
    const name = createSalonDto.name.trim();
    const email = createSalonDto.email.trim().toLowerCase();
    const category = createSalonDto.category.trim();
    const specialty = createSalonDto.specialty.trim();
    const salonPhone = createSalonDto.salonPhone.trim();
    const address = createSalonDto.address.trim();
    const city = createSalonDto.city.trim();
    const postalCode = createSalonDto.postalCode.trim();
    const country = createSalonDto.country.trim();
    const description = createSalonDto.description?.trim();

    // Verification metier simple avant creation.
    if (
      !name ||
      !email ||
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
      where: { email },
    });

    if (existingSalon) {
      throw new BadRequestException('Un salon utilise deja cet email');
    }

    // On prepare l'objet SalonEntity avant de l'enregistrer.
    const newSalon = this.salonsRepository.create({
      name,
      description,
      category,
      specialty,
      phone: salonPhone,
      email,
      address,
      city,
      postalCode,
      country,
    });

    // save() fait l'INSERT en base de donnees.
    const createdSalon = await this.salonsRepository.save(newSalon);

    return {
      message: 'Salon cree avec succes',
      salon: createdSalon,
    };
  }
}