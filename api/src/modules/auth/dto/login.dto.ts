import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

// Donnees attendues lors de la connexion.
export class LoginDto {
  @IsEmail({}, { message: 'L email doit etre valide' })
  @IsNotEmpty({ message: 'L email est obligatoire' })
  @ApiProperty({
    example: 'theo@test.com',
    description: "Adresse email de l'utilisateur",
  })
  email: string;

  @IsString({ message: 'Le mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le mot de passe est obligatoire' })
  @ApiProperty({
    example: 'Motdepasse1*',
    description: "Mot de passe de l'utilisateur",
  })
  password: string;
}
