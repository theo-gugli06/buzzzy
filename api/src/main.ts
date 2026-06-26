import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import { ValidationPipe } from '@nestjs/common';

import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';



async function bootstrap() {
  // Cree et demarre l'application NestJS.
  const app = await NestFactory.create(AppModule);

  // Active la validation automatique des DTO.
  // whitelist garde uniquement les champs declares dans les DTO.
  // forbidNonWhitelisted refuse les champs inconnus envoyes dans une requete.
  // Les champs non prevus dans les DTO sont refuses.
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
    }),
  );


  const config = new DocumentBuilder()
    .setTitle('Buzzzy API')
    .setDescription("Documentation de l'API Buzzzy")
    .setVersion('1.0')
    .addTag('Auth') 
    .addBearerAuth() // Ajoute le bouton Authorize pour tester les routes protegees avec le token JWT.
    .build();
  const documentFactory = () => SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, documentFactory);

  // Lance le serveur sur le port configure, ou 3000 par defaut.
  await app.listen(process.env.PORT ?? 3000);
}

// Execute la fonction de demarrage de l'API.
bootstrap();
