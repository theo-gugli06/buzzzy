import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { SalonEntity } from './entities/salon.entity';
import { SalonsController } from './controllers/salons.controller';
import { SalonsService } from './services/salons.service';
import { SalonMembersModule } from '../salon-members/salon-members.module';
import { UsersModule } from '../users/users.module';
import { RoleEntity } from '../roles/entities/role.entity';

@Module({
  imports: [
    // Rend SalonEntity et RoleEntity utilisables avec des repositories TypeORM.
    TypeOrmModule.forFeature([SalonEntity, RoleEntity]),

    // Permet a SalonsService de creer un utilisateur.
    UsersModule,

    // Permet a SalonsService de creer le lien user/salon/role.
    SalonMembersModule,
  ],

  controllers: [SalonsController],

  providers: [SalonsService],
})
export class SalonsModule {}