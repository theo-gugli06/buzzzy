import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

// Entity liee a la table SQL "role".
// Elle represente les roles disponibles dans l'application.
@Entity('role')
export class RoleEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 50, unique: true })
  name: string;

  @Column({ length: 100 })
  label: string;
}