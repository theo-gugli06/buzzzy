import {
  IsEmail, // Verifie que la valeur ressemble a un email valide.
  IsNotEmpty, // Verifie que le champ n'est pas vide.
  IsOptional, // Indique qu'un champ n'est pas obligatoire.
  IsString, // Verifie que la valeur est une chaine de caracteres.
  MinLength, // Verifie une longueur minimale, utile pour le mot de passe.
} from 'class-validator';

import {
  ApiProperty, // Documente un champ obligatoire dans Swagger.
  ApiPropertyOptional, // Documente un champ facultatif dans Swagger.
} from '@nestjs/swagger';

// Donnees attendues pour creer un salon depuis le parcours pro.
export class CreateSalonDto {
  @IsString({ message: 'Le mode de compte doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le mode de compte est obligatoire' })
  @ApiProperty({
    example: 'create',
    description: 'Indique si le parcours utilise une creation de compte ou une connexion',
  })
  accountMode: string;

  @IsOptional()
  @IsString({ message: 'Le prenom doit etre une chaine de caracteres' })
  @ApiPropertyOptional({
    example: 'Theo',
    description: "Prenom de l'utilisateur si le compte est cree pendant le parcours pro",
  })
  firstname?: string;

  @IsOptional()
  @IsString({ message: 'Le nom doit etre une chaine de caracteres' })
  @ApiPropertyOptional({
    example: 'Guglielmini',
    description: "Nom de l'utilisateur si le compte est cree pendant le parcours pro",
  })
  lastname?: string;

  // Telephone user
  @IsOptional()
  @IsString({ message: 'Le telephone utilisateur doit etre une chaine de caracteres' })
  @ApiPropertyOptional({
    example: '0600000000',
    description: "Telephone du compte utilisateur",
  })
  userPhone?: string;

  @IsEmail({}, { message: 'L email doit etre valide' })
  @IsNotEmpty({ message: 'L email est obligatoire' })
  @ApiProperty({
    example: 'theo@test.com',
    description: "Email du compte utilise pour creer le salon",
  })
  email: string;

  @IsOptional()
  @IsString({ message: 'Le mot de passe doit etre une chaine de caracteres' })
  @MinLength(12, { message: 'Le mot de passe doit contenir au moins 12 caracteres' })
  @ApiPropertyOptional({
    example: 'Motdepasse1*',
    description: 'Mot de passe si le compte est cree pendant le parcours pro',
    minLength: 12,
  })
  password?: string;

  @IsOptional()
  @IsString({ message: 'La confirmation du mot de passe doit etre une chaine de caracteres' })
  @MinLength(12, { message: 'La confirmation du mot de passe doit contenir au moins 12 caracteres' })
  @ApiPropertyOptional({
    example: 'Motdepasse1*',
    description: 'Confirmation du mot de passe si le compte est cree pendant le parcours pro',
    minLength: 12,
  })
  confirmPassword?: string;




  
  @IsString({ message: 'La categorie doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'La categorie est obligatoire' })
  @ApiProperty({
    example: 'hair',
    description: 'Categorie principale du salon choisie dans le parcours pro',
  })
  category: string;

  @IsString({ message: 'La specialite doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'La specialite est obligatoire' })
  @ApiProperty({
    example: 'Barbershop',
    description: 'Specialite precise choisie apres la categorie',
  })
  specialty: string;

  @IsString({ message: 'Le nom du salon doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le nom du salon est obligatoire' })
  @ApiProperty({
    example: 'Salon Martin',
    description: 'Nom commercial du salon',
  })
  name: string;

  @IsOptional()
  @IsString({ message: 'La description doit etre une chaine de caracteres' })
  @ApiPropertyOptional({
    example: 'Salon specialise en coiffure et barber',
    description: 'Description facultative du salon',
  })
  description?: string;

  // Telephone salon
  @IsString({ message: 'Le telephone du salon doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le telephone du salon est obligatoire' })
  @ApiProperty({
    example: '0600000000',
    description: 'Telephone public du salon',
  })
  salonPhone: string;

  @IsString({ message: 'L adresse doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'L adresse est obligatoire' })
  @ApiProperty({
    example: '12 rue de Paris',
    description: 'Adresse du salon',
  })
  address: string;

  @IsString({ message: 'La ville doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'La ville est obligatoire' })
  @ApiProperty({
    example: 'Paris',
    description: 'Ville du salon',
  })
  city: string;

  @IsString({ message: 'Le code postal doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le code postal est obligatoire' })
  @ApiProperty({
    example: '75001',
    description: 'Code postal du salon',
  })
  postalCode: string;

  @IsString({ message: 'Le pays doit etre une chaine de caracteres' })
  @IsNotEmpty({ message: 'Le pays est obligatoire' })
  @ApiProperty({
    example: 'France',
    description: 'Pays du salon',
  })
  country: string;
}