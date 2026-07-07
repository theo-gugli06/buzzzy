import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_contact_details_widget.dart';

class ProContactDetailsScreen extends StatelessWidget {
  const ProContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère les données envoyées depuis la page précédente.
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final category = arguments['category']!;
    final specialty = arguments['specialty']!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(),
          Expanded(
            child: ProContactDetailsWidget(
              category: category,
              specialty: specialty,
            ),
          ),
        ],
      ),
    );
  }
}
