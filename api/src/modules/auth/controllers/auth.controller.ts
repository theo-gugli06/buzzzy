import { Body, Controller, Get, Post, Request, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../guards/jwt-auth.guard';

import { LoginDto } from '../dto/login.dto';
import { RegisterDto } from '../dto/register.dto';
import { AuthService } from '../services/auth.service';

import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  // Route d'inscription: cree un compte utilisateur.
  @Post('register')
  @ApiCreatedResponse({
    description: 'Utilisateur inscrit avec succes',
  })
  @ApiBadRequestResponse({
    description: 'Donnees invalides, email deja utilise ou mots de passe differents',
  })
  register(@Body() registerDto: RegisterDto) {
    return this.authService.register(registerDto);
  }

  // Route de connexion: verifie les identifiants et renvoie un JWT.
  @Post('login')
  @ApiOkResponse({
    description: 'Utilisateur connecte avec succes',
  })
  @ApiBadRequestResponse({
    description: 'Email ou mot de passe invalide',
  })
  login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto);
  }

  // Route protegee: renvoie le profil de l'utilisateur connecte.
  @Get('me')
  @UseGuards(JwtAuthGuard)
  me(@Request() req) {
    return this.authService.getProfile(req.user.userId);
  }
}
