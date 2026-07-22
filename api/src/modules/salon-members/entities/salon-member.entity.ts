import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

// Entity liee a la table SQL "salonMember".
// Elle relie un utilisateur a un salon avec un role precis.
@Entity('salonMember')
export class SalonMemberEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'userId' })
  userId: number;

  @Column({ name: 'salonId' })
  salonId: number;

  @Column({ name: 'roleId' })
  roleId: number;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn({ nullable: true })
  updatedAt: Date;
}