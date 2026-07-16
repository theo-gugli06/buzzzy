import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_salon_info_widget.dart';

class ProSalonInfoScreen extends StatelessWidget {
  const ProSalonInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    // Données récupérées depuis les pages précédentes du parcours pro.
    final category = arguments['category']!;
    final specialty = arguments['specialty']!;

    // Indique si l'utilisateur vient du mode création de compte ou connexion.
    final accountMode = arguments['accountMode']!;

    // Données du compte envoyées depuis la page précédente.
    final firstname = arguments['firstname'];
    final lastname = arguments['lastname'];
    final phone = arguments['phone'];
    // Le "!" indique que l'email est obligatoire ici.
    // Il est envoyé dans les deux cas : création de compte et connexion.
    final email = arguments['email']!;
    final password = arguments['password'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(showBackButton: true),
          Expanded(
            child: ProSalonInfoWidget(
              category: category,
              specialty: specialty,
              accountMode: accountMode,
              firstname: firstname,
              lastname: lastname,
              phone: phone,
              email: email,
              password: password,
            ),
          ),
        ],
      ),
    );
  }
}
