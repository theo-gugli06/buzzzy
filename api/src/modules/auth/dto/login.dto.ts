import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class LoginDto {
  @IsEmail({}, { message: 'L email doit etre valide' })
  @IsNotEmpty({ message: 'L email est obligatoire' })
  email: string;

  @IsString({ message: 'Le mot de passe doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le mot de passe est obligatoire' })
  password: string;
}
