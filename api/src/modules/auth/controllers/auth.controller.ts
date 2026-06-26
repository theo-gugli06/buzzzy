import { Body, Controller, Get, HttpCode, Post, Request, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../guards/jwt-auth.guard';

import { LoginDto } from '../dto/login.dto';
import { RegisterDto } from '../dto/register.dto';
import { AuthService } from '../services/auth.service';

import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  // Route d'inscription: cree un compte utilisateur.
  @Post('register')
   @ApiOperation({
   summary: 'Inscrire un nouvel utilisateur',
   description:
      "Cree un compte utilisateur avec les informations envoyees dans le corps de la requete.",
 })
   @ApiBody({
    type: RegisterDto,
    description: "Donnees necessaires pour creer un compte utilisateur Buzzzy.",
  })
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
  @HttpCode(200)
  @ApiOperation({
    summary: 'Connecter un utilisateur',
    description:
      'Verifie les identifiants et renvoie un token JWT si la connexion reussit.',
  })  @ApiBody({
    type: LoginDto,
    description: "Identifiants necessaires pour connecter un utilisateur.",
  })
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
  @ApiOperation({
    summary: "Recuperer le profil de l'utilisateur connecte",
    description:
      "Renvoie les informations de l'utilisateur associe au token JWT.",
  })
  @ApiBearerAuth()
  @ApiOkResponse({
    description: "Profil de l'utilisateur connecte recupere avec succes",
  })
  @ApiUnauthorizedResponse({
    description: 'Token JWT manquant, invalide ou expire',
  })
  @UseGuards(JwtAuthGuard)
  me(@Request() req) {
    return this.authService.getProfile(req.user.userId);
  }
}
