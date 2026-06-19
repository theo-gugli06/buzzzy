import 'package:flutter/material.dart';

import '../../../auth/services/auth_api_service.dart';
import '../../../auth/services/auth_session_service.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({super.key});

  // Récupère le prénom de l'utilisateur connecté grâce au token stocké.
  Future<String> _getFirstname() async {
    // Lit le token JWT enregistré après la connexion.
    final token = await AuthSessionService.getToken();

    // Si aucun token n'existe, l'utilisateur n'est pas connecté.
    if (token == null) {
      throw Exception('Utilisateur non connecté');
    }

    // Appelle /auth/me pour récupérer le profil utilisateur.
    final user = await AuthApiService.getMe(token: token);

    // Retourne le prénom reçu depuis l'API.
    return user['firstname'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // FutureBuilder attend le résultat de _getFirstname().
      body: FutureBuilder<String>(
        future: _getFirstname(),
        builder: (context, snapshot) {
          // Pendant le chargement, on affiche un loader.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Si le token est absent/invalide ou si l'API échoue.
          if (snapshot.hasError) {
            return const Center(
              child: Text('Impossible de charger la session'),
            );
          }

          // Prénom récupéré depuis l'API.
          final firstname = snapshot.data ?? '';

          // Affichage final quand la session est valide.
          return Center(
            child: Text(
              'Bienvenue $firstname',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}