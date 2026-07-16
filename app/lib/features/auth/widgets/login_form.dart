// Widget qui contiendra le formulaire de connexion.
import 'package:app/core/widgets/buzzzy_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/app/routes.dart';
import '../services/auth_session_service.dart';

import '../services/auth_api_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controller qui permet de récupérer le texte tapé dans le champ email.
  final TextEditingController emailController = TextEditingController();

  // Controller qui permet de récupérer le texte tapé dans le champ mot de passe.
  final TextEditingController passwordController = TextEditingController();

  // Fonction appelée quand l'utilisateur appuie sur le bouton "Se connecter".
  Future<void> _handleLogin() async {
    // Récupère l'email tapé et enlève les espaces au début/à la fin.
    final email = emailController.text.trim();

    // Récupère le mot de passe tapé et enlève les espaces au début/à la fin.
    final password = passwordController.text.trim();

    // Si un des deux champs est vide, on arrête la fonction.
    if (email.isEmpty || password.isEmpty) {
      return;
    }

    try {
      // Appelle l'API de connexion avec email et mot de passe.
      final data = await AuthApiService.login(email: email, password: password);

      final token = data['accessToken'] as String;
      await AuthSessionService.saveToken(token);

      final savedToken = await AuthSessionService.getToken();

      if (savedToken == null) {
        throw Exception('Token non stocké');
      }

     await AuthApiService.getMe(token: savedToken);

if (!mounted) return;

Navigator.pushReplacementNamed(context, AppRoutes.clientHome);
    } catch (error) {
      // Vérifie que le widget existe encore avant d'afficher l'erreur.
      if (!mounted) return;

      // Affiche le message d'erreur si la connexion échoue.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BuzzzyTopBar(showBackButton: true),

        const SizedBox(height: 30),

        const Text(
          'Vous avez déjà utilisé Buzzzy ?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email *',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 3),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mot de passe *',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 3),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Se connecter',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              const Expanded(
                child: Divider(color: Color(0xFFDADADA), thickness: 1),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'ou',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),

              const Expanded(
                child: Divider(color: Color(0xFFDADADA), thickness: 1),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Nouveau sur Buzzzy ?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Créer mon compte',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Gestion des cookies',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
