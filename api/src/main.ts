import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  // Cree et demarre l'application NestJS.
  const app = await NestFactory.create(AppModule);

  // Lance le serveur sur le port configure, ou 3000 par defaut.
  await app.listen(process.env.PORT ?? 3000);
}

bootstrap();