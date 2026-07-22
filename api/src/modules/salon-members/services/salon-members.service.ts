import { Injectable } from '@nestjs/common'; // Permet a NestJS d'injecter ce service ailleurs.
import { InjectRepository } from '@nestjs/typeorm'; // Permet de connecter un repository TypeORM a une entity.
import { Repository } from 'typeorm'; // Donne les methodes TypeORM comme create et save.

import { SalonMemberEntity } from '../entities/salon-member.entity'; // Entity liee a la table SQL "salonMember".

@Injectable()
export class SalonMembersService {
  constructor(
    // Repository TypeORM pour interagir avec la table "salonMember".
    @InjectRepository(SalonMemberEntity)
    private readonly salonMembersRepository: Repository<SalonMemberEntity>,
  ) {}

  create(salonMemberData: Partial<SalonMemberEntity>) {
    // Prepare une nouvelle ligne salonMember avec userId, salonId et roleId.
    const newSalonMember =
      this.salonMembersRepository.create(salonMemberData);

    // Enregistre la ligne dans la table "salonMember".
    return this.salonMembersRepository.save(newSalonMember);
  }
}