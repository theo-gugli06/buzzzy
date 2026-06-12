import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { UserEntity } from './entities/user.entity';
import { UsersService } from './services/users.service';

@Module({
  // Rend UserEntity utilisable avec le repository TypeORM.
  imports: [TypeOrmModule.forFeature([UserEntity])],

  providers: [UsersService],

  // Permet a AuthModule d'utiliser UsersService.
  exports: [UsersService],
})
export class UsersModule {}