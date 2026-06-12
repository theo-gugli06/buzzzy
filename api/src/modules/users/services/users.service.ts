import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { UserEntity } from '../entities/user.entity';

@Injectable()
export class UsersService {
  constructor(
    // Repository TypeORM pour interagir avec la table "user".
    @InjectRepository(UserEntity)
    private readonly usersRepository: Repository<UserEntity>,
  ) {}

  // Recherche un utilisateur avec son email.
  findByEmail(email: string) {
    return this.usersRepository.findOne({
      where: { email },
    });
  }

  // Recherche un utilisateur avec son id.
  findById(id: number) {
    return this.usersRepository.findOne({
      where: { id },
    });
  }

  // Cree un nouvel utilisateur en base de donnees.
  create(userData: Partial<UserEntity>) {
    const newUser = this.usersRepository.create(userData);
    return this.usersRepository.save(newUser);
  }
}