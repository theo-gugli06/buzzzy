import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AuthModule } from './modules/auth/auth.module';
import { UsersModule } from './modules/users/users.module';

// Module principal de l'API.
@Module({
  imports: [
    // Charge les variables du fichier .env dans toute l'application.
    ConfigModule.forRoot({
      isGlobal: true,
    }),

    // Configure la connexion a PostgreSQL avec TypeORM.
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],

      // Recupere les informations de connexion depuis le fichier .env.
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST'),
        port: Number(configService.get<string>('DB_PORT')),
        username: configService.get<string>('DB_USERNAME'),
        password: configService.get<string>('DB_PASSWORD'),
        database: configService.get<string>('DB_NAME'),

        // Charge automatiquement les entities declarees dans les modules.
        autoLoadEntities: true,

        // Desactive la modification automatique de la BDD.
        // Le schema est gere par le fichier SQL.
        synchronize: false,
      }),
    }),

    // Modules metier de l'application.
    AuthModule,
    UsersModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}