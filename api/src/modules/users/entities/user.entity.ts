import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';


// Entity liee a la table SQL "user".
@Entity('user')
export class UserEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255, unique: true })
  email: string;

  // Mot de passe stocke sous forme hashee.
  @Column({ length: 255 })
  password: string;

  @Column({ length: 100 })
  firstname: string;

  @Column({ length: 100 })
  lastname: string;

  @Column({ length: 30, nullable: true })
  phone?: string;

  // Permet de desactiver un compte sans le supprimer de la base.
  @Column({ default: true })
  isActive: boolean;

  // Date de creation automatiquement remplie par TypeORM.
  @CreateDateColumn()
  createdAt: Date;

  // Date de derniere modification automatiquement mise a jour.
  @UpdateDateColumn({ nullable: true })
  updatedAt: Date;
}
