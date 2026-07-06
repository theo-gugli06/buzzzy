import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_establishment_details_widget.dart';

class ProEstablishmentDetailsScreen extends StatelessWidget {
  const ProEstablishmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(),
          Expanded(
            child: ProEstablishmentDetailsWidget(category: category),
          ),
        ],
      ),
    );
  }
}