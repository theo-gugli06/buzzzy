import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { SalonEntity } from './entities/salon.entity';
import { SalonsController } from './controllers/salons.controller';
import { SalonsService } from './services/salons.service';

@Module({
  imports: [
    // Rend SalonEntity utilisable avec le repository TypeORM.
    TypeOrmModule.forFeature([SalonEntity]),
  ],

  controllers: [SalonsController],

  providers: [SalonsService],
})
export class SalonsModule {}