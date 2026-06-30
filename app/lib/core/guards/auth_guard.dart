import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../features/auth/services/auth_api_service.dart';
import '../../features/auth/services/auth_session_service.dart';

// Widget qui protège une page privée.
// Il reçoit une page dans "child" et ne l'affiche que si la session est valide.
class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key, required this.child});

  // Page à protéger, par exemple ClientHomeScreen.
  final Widget child;

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

// Etat interne de AuthGuard.
// C'est ici que la vérification de session est lancée et utilisée.
class _AuthGuardState extends State<AuthGuard> {
  // Contient la vérification de session en cours.
  // Le résultat sera true si la session est valide, false sinon.
  late final Future<bool> _sessionFuture;

  @override
  void initState() {
    super.initState();

    // initState est appelé une seule fois quand AuthGuard démarre.
    // On lance donc la vérification ici pour éviter de la relancer à chaque build.
    _sessionFuture = _checkSession();
  }

  // Vérifie si l'utilisateur possède une session valide.
  Future<bool> _checkSession() async {
    // On récupère le token stocké localement dans l'application.
    final token = await AuthSessionService.getToken();

    // Aucun token signifie que l'utilisateur n'est pas connecté.
    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      // On demande au backend si le token est encore valide.
      await AuthApiService.getMe(token: token);

      // Si l'appel réussit, la session est valide.
      return true;
    } catch (error) {
      // Si l'API refuse le token, on supprime le token local.
      await AuthSessionService.clearToken();

      // La session est considérée comme invalide.
      return false;
    }
  }

  // Redirige vers la page de connexion.
  void _redirectToLogin() {
    // On attend que Flutter termine le rendu actuel avant de naviguer.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Si le widget n'existe plus, on évite de naviguer avec un context invalide.
      if (!mounted) return;

      // Remplace la page actuelle par la route login.
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      // FutureBuilder attend le résultat de la vérification de session.
      future: _sessionFuture,

      builder: (context, snapshot) {
        // Si la session est valide, on affiche la page protégée.
        if (snapshot.data == true) {
          return widget.child;
        }

        // Si la vérification est terminée mais que la session n'est pas valide,
        // on redirige l'utilisateur vers login.
        if (snapshot.connectionState == ConnectionState.done) {
          _redirectToLogin();

          // Page vide temporaire pendant que la redirection se fait.
          return const Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox.shrink(),
          );
        }

        // Pendant la vérification, on affiche un indicateur de chargement.
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}