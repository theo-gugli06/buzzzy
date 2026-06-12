import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';


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

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn({ nullable: true })
  updatedAt: Date;
}