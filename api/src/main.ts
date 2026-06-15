import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import { ValidationPipe } from '@nestjs/common';

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

  // Lance le serveur sur le port configure, ou 3000 par defaut.
  await app.listen(process.env.PORT ?? 3000);
}

// Execute la fonction de demarrage de l'API.
bootstrap();
