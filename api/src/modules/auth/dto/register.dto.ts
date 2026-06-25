import {
  IsEmail,
  IsNotEmpty,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';

import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

// Donnees attendues lors de l'inscription.
export class RegisterDto {
  @IsEmail({}, { message: 'L email doit etre valide' })
  @IsNotEmpty({ message: 'L email est obligatoire' })
  @ApiProperty({
    example: 'theo@test.com',
    description: "Adresse email de l'utilisateur",
  })
  email: string;

  @IsString({ message: 'Le mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le mot de passe est obligatoire' })
  @MinLength(12, { message: 'Le mot de passe doit contenir au moins 12 caracteres' })
  @ApiProperty({
    example: 'Motdepasse1*',
    description: 'Mot de passe, minimum 12 caracteres',
    minLength: 12,
  })
  password: string;

  @IsString({ message: 'La confirmation du mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'La confirmation du mot de passe est obligatoire' })
  @MinLength(12, { message: 'La confirmation du mot de passe doit contenir au moins 12 caracteres' })
  @ApiProperty({
    example: 'Motdepasse1*',
    description: 'Confirmation du mot de passe, minimum 12 caracteres',
    minLength: 12,
  })
  confirmPassword: string;

  @IsString({ message: 'Le prenom doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le prenom est obligatoire' })
  @ApiProperty({
    example: 'Theo',
    description: "Prenom de l'utilisateur",
  })
  firstname: string;

  @IsString({ message: 'Le nom doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le nom est obligatoire' })
  @ApiProperty({
    example: 'Guglielmini',
    description: "Nom de l'utilisateur",
  })
  lastname: string;

  // Telephone facultatif pour limiter les donnees personnelles collectees.
  @IsOptional()
  @IsString({ message: 'Le telephone doit etre une chaine de caracteres' })
  @ApiPropertyOptional({
    example: '0600000000',
    description: "Numero de telephone de l'utilisateur",
  })
  phone?: string;
}
