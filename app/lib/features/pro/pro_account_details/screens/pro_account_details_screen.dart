import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_account_details_widget.dart';

class ProAccountDetailsScreen extends StatelessWidget {
  const ProAccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère les données envoyées depuis la page précédente.
    // Ici, on attend une Map avec des clés comme "category" et "specialty".
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    // On récupère la catégorie choisie : hair, beauty ou wellness.
    // Le "!" veut dire : je suis sûr que cette valeur existe et qu'elle n'est pas null.
    final category = arguments['category']!;
    final specialty = arguments['specialty']!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(showBackButton: true),
          Expanded(
            child: ProAccountDetailsWidget(
               // On envoie la catégorie récupérée au widget.
              category: category,
              specialty: specialty,
            ),
          ),
        ],
      ),
    );
  }
}
