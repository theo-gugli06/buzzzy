import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';

import { JwtModule } from '@nestjs/jwt';
import type { JwtSignOptions } from '@nestjs/jwt';
import { JwtStrategy } from './strategies/jwt.strategy';

import { UsersModule } from '../users/users.module';
import { AuthController } from './controllers/auth.controller';
import { AuthService } from './services/auth.service';

@Module({
  imports: [
    // AuthModule utilise UsersModule pour chercher ou creer des utilisateurs.
    UsersModule,

    // Configure le module JWT avec les variables du fichier .env.
    JwtModule.registerAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        // Cle secrete utilisee pour signer et verifier les tokens.
        secret: configService.get<string>('JWT_SECRET'),
        signOptions: {
          // Duree de validite du token, avec 1 jour par defaut.
          expiresIn:
            configService.get<JwtSignOptions['expiresIn']>('JWT_EXPIRES_IN') ?? '1d',
        },
      }),
    }),
  ],
  controllers: [AuthController],
// AuthService gere register/login, JwtStrategy verifie les tokens recus.
providers: [AuthService, JwtStrategy],
})
export class AuthModule { }
