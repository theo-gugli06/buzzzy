import { Body, Controller, Post } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBody,
  ApiCreatedResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import { CreateSalonDto } from '../dto/create-salon.dto';
import { SalonsService } from '../services/salons.service';

@ApiTags('Salons')
@Controller('pro/salons')
export class SalonsController {
  constructor(private readonly salonsService: SalonsService) {}

  // @Post() indique que cette methode repond a une requete HTTP POST.
  // Donc ici, la route sera : POST /pro/salons
  @Post()
  @ApiOperation({
    summary: 'Creer un salon depuis le parcours pro',
    description:
      'Recoit les donnees du parcours pro pour creer le compte, le salon et le salonMember ensuite.',
  })
  @ApiBody({
    type: CreateSalonDto,
    description: 'Donnees envoyees depuis le formulaire pro Flutter.',
  })
  @ApiCreatedResponse({
    description: 'Salon cree avec succes',
  })
  @ApiBadRequestResponse({
    description: 'Donnees invalides ou creation impossible',
  })
  create(
    // @Body() recupere le JSON envoye dans le corps de la requete.
    // CreateSalonDto sert a typer et valider les donnees recues.
    @Body() createSalonDto: CreateSalonDto,
  ) {
    // On envoie les donnees au service, qui contiendra la vraie logique.
    return this.salonsService.create(createSalonDto);
  }
}