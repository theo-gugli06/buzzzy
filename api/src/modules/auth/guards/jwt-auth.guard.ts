import { Injectable } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
// Guard utilise sur les routes qui demandent un token JWT valide.
export class JwtAuthGuard extends AuthGuard('jwt') {}
