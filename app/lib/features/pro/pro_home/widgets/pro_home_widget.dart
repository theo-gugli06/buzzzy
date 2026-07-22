import 'package:flutter/material.dart';

class ProHomeWidget extends StatelessWidget {
  const ProHomeWidget({
    super.key,
    required this.message,
    required this.salonName,
    required this.firstname,
  });

  // Message renvoyé par l'API.
  final String message;

  // Nom du salon créé.
  final String salonName;

  // Prénom du user créé.
  final String firstname;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),

        Text(
          message,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          'Bienvenue $firstname dans l’espace pro de $salonName',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}