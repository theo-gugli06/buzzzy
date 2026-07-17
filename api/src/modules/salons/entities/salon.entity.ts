import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

// Entity liee a la table SQL "salon".
// Elle permet a NestJS/TypeORM de manipuler les salons en base de donnees.
@Entity('salon')
export class SalonEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255 })
  name: string;

  @Column({ length: 1000, nullable: true })
  description?: string;

  @Column({ length: 100 })
  category: string;

  @Column({ length: 100 })
  specialty: string;

  @Column({ length: 30 })
  phone: string;

  @Column({ length: 255, unique: true })
  email: string;

  @Column({ length: 255 })
  address: string;

  @Column({ length: 100 })
  city: string;

  @Column({ name: 'postalCode', length: 20 })
  postalCode: string;

  @Column({ length: 100 })
  country: string;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  latitude?: string;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  longitude?: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn({ nullable: true })
  updatedAt: Date;
}