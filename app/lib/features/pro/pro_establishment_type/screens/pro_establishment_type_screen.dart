import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_establishment_type_widget.dart';

class ProEstablishmentTypeScreen extends StatelessWidget {
  const ProEstablishmentTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          BuzzzyTopBar(showBackButton: true),
          Expanded(
            child: ProEstablishmentTypeWidget(),
          ),
        ],
      ),
    );
  }
}