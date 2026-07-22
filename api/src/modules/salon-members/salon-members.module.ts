import { Module } from '@nestjs/common'; // Permet de declarer un module NestJS.
import { TypeOrmModule } from '@nestjs/typeorm'; // Permet de connecter une entity TypeORM au module.

import { SalonMemberEntity } from './entities/salon-member.entity'; // Entity liee a la table SQL "salonMember".
import { SalonMembersService } from './services/salon-members.service'; // Service qui gerera la creation des liens salon/user/role.

@Module({
  imports: [
    // Rend SalonMemberEntity utilisable avec un repository TypeORM.
    TypeOrmModule.forFeature([SalonMemberEntity]),
  ],

  providers: [SalonMembersService],

  // Permet a un autre module, comme SalonsModule,
  // d'utiliser SalonMembersService.
  exports: [SalonMembersService],
})
export class SalonMembersModule {}