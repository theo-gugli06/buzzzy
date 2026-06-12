import { BadRequestException, Injectable } from '@nestjs/common';
import * as argon2 from 'argon2';
import { LoginDto } from '../dto/login.dto';

import { JwtService } from '@nestjs/jwt';

import { UsersService } from '../../users/services/users.service';
import { RegisterDto } from '../dto/register.dto';

@Injectable()
export class AuthService {
    constructor(
        private readonly usersService: UsersService,
        private readonly jwtService: JwtService,
    ) { }

    async register(registerDto: RegisterDto) {
        const email = registerDto.email.trim().toLowerCase();
        const password = registerDto.password.trim();
        const confirmPassword = registerDto.confirmPassword.trim();
        const firstname = registerDto.firstname.trim();
        const lastname = registerDto.lastname.trim();
        const phone = registerDto.phone?.trim();

        // Verifie les champs obligatoires.
        if (!email || !password || !confirmPassword || !firstname || !lastname) {
            throw new BadRequestException('Tous les champs obligatoires doivent etre remplis');
        }

        if (!email.includes('@')) {
            throw new BadRequestException('Le format de l email est invalide');
        }

        if (password.length < 12) {
            throw new BadRequestException(
                'Le mot de passe doit contenir au moins 12 caracteres',
            );
        }

        if (password !== confirmPassword) {
            throw new BadRequestException(
                'Le mot de passe et la confirmation ne correspondent pas',
            );
        }

        // Verifie que l'email n'est pas deja utilise.
        const existingUser = await this.usersService.findByEmail(email);

        if (existingUser) {
            throw new BadRequestException('Cet email est deja utilise');
        }

        // Hash du mot de passe avant stockage en base.
        const hashedPassword = await argon2.hash(password);

        const createdUser = await this.usersService.create({
            email,
            password: hashedPassword,
            firstname,
            lastname,
            phone,
        });

        return {
            message: 'Inscription reussie',
            user: {
                id: createdUser.id,
                email: createdUser.email,
                firstname: createdUser.firstname,
                lastname: createdUser.lastname,
                phone: createdUser.phone,
            },
        };
    }

    async login(loginDto: LoginDto) {
        const email = loginDto.email.trim().toLowerCase();
        const password = loginDto.password.trim();

        if (!email || !password) {
            throw new BadRequestException('Email et mot de passe obligatoires');
        }

        const user = await this.usersService.findByEmail(email);

        if (!user) {
            throw new BadRequestException('Identifiants invalides');
        }

        const isPasswordValid = await argon2.verify(user.password, password);

        if (!isPasswordValid) {
            throw new BadRequestException('Identifiants invalides');
        }

        const payload = {
            sub: user.id,
            email: user.email,
        };

        const accessToken = await this.jwtService.signAsync(payload);
        return {
            message: 'Connexion reussie',
            accessToken,
            user: {
                id: user.id,
                email: user.email,
                firstname: user.firstname,
                lastname: user.lastname,
                phone: user.phone,
            },
        };
    }
}
