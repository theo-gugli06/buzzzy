import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../features/auth/services/auth_api_service.dart';
import '../../features/auth/services/auth_session_service.dart';

// Widget réutilisable qui protège une page privée.
// Il reçoit une page dans "child" et l'affiche seulement si la session est valide.
class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key, required this.child});

  // Page protégée, par exemple ClientHomeScreen.
  final Widget child;

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

// Etat interne du guard.
// Il lance la vérification de session et décide quoi afficher.
class _AuthGuardState extends State<AuthGuard> {
  late final Future<bool> _sessionFuture;

  @override
  void initState() {
    super.initState();

    // Lance la vérification une seule fois quand le guard démarre.
    _sessionFuture = _checkSession();
  }

  // Vérifie si l'utilisateur a un token valide.
  // Retourne true si la session est acceptée par l'API, sinon false.
  Future<bool> _checkSession() async {
    final token = await AuthSessionService.getToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      await AuthApiService.getMe(token: token);
      return true;
    } catch (error) {
      // Si le token est expiré ou invalide, on nettoie la session locale.
      await AuthSessionService.clearToken();
      return false;
    }
  }

  // Redirige l'utilisateur vers la page de connexion.
  void _redirectToLogin() {
    // Attend la fin du rendu actuel avant de lancer la navigation.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return widget.child;
        }

        if (snapshot.connectionState == ConnectionState.done) {
          _redirectToLogin();

          return const Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox.shrink(),
          );
        }

        // Affiché pendant que le token est en cours de vérification.
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
