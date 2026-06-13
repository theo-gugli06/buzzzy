import {
  IsEmail,
  IsNotEmpty,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';

export class RegisterDto {
  @IsEmail({}, { message: 'L email doit etre valide' })
  @IsNotEmpty({ message: 'L email est obligatoire' })
  email: string;

  @IsString({ message: 'Le mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le mot de passe est obligatoire' })
  @MinLength(12, { message: 'Le mot de passe doit contenir au moins 12 caracteres' })
  password: string;

  @IsString({ message: 'La confirmation du mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'La confirmation du mot de passe est obligatoire' })
  @MinLength(12, { message: 'La confirmation du mot de passe doit contenir au moins 12 caracteres' })
  confirmPassword: string;

  @IsString({ message: 'Le prenom doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le prenom est obligatoire' })
  firstname: string;

  @IsString({ message: 'Le nom doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le nom est obligatoire' })
  lastname: string;

  @IsOptional()
  @IsString({ message: 'Le telephone doit etre une chaine de caracteres' })
  phone?: string;
}
