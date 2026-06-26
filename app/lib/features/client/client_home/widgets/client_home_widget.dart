import 'package:flutter/material.dart';

import '../../../auth/services/auth_api_service.dart';
import '../../../auth/services/auth_session_service.dart';

import '../../../../app/routes.dart';

class ClientHomeWidget extends StatelessWidget {
  const ClientHomeWidget({super.key});

  Future<String> _getFirstname() async {
    final token = await AuthSessionService.getToken();

    if (token == null) {
      throw Exception('Utilisateur non connecté');
    }

    final user = await AuthApiService.getMe(token: token);

    return user['firstname'] ?? '';
  }

         Future<void> _handleLogout(BuildContext context) async {
          // Supprime le token JWT stocké sur le téléphone.
          await AuthSessionService.clearToken();

          // Vérifie que la page existe encore après l'action asynchrone.
          if (!context.mounted) return;

          // Redirige l'utilisateur vers la page de connexion.
          // pushReplacementNamed remplace la page actuelle pour éviter le retour arrière.
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getFirstname(),
      builder: (context, snapshot) {
        // Pendant le chargement, on affiche un loader.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Si le token est absent/invalide ou si l'API échoue.
        if (snapshot.hasError) {
          return const Center(child: Text('Impossible de charger la session'));
        }

        // Prénom récupéré depuis l'API.
        final firstname = snapshot.data ?? '';

 

        // Affichage final quand la session est valide.
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bienvenue $firstname',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
