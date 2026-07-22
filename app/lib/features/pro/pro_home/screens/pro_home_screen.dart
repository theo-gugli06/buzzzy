import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_home_widget.dart';

class ProHomeScreen extends StatelessWidget {
  const ProHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère les données envoyées par ProSalonInfoWidget.
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Le "??" donne une valeur par défaut si la donnée est absente.
    final message = arguments['message'] ?? 'Salon créé avec succès';
    final salonName = arguments['salonName'] ?? 'votre salon';
    final firstname = arguments['firstname'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const BuzzzyTopBar(),
          Expanded(
            child: ProHomeWidget(
              message: message,
              salonName: salonName,
              firstname: firstname,
            ),
          ),
        ],
      ),
    );
  }
}