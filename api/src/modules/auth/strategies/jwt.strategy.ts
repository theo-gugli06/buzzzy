import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly configService: ConfigService) {
  super({
  // Lit le token dans le header: Authorization: Bearer TOKEN.
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  // Utilise la cle secrete du .env pour verifier la signature du token.
  secretOrKey: configService.getOrThrow<string>('JWT_SECRET'),
});
  }

  // Transforme le payload du token en utilisateur disponible dans req.user.
  validate(payload: { sub: number; email: string }) {
    return {
      userId: payload.sub,
      email: payload.email,
    };
  }
}
