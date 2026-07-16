import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_salon_info_widget.dart';
import '../../shared/models/pro_flow_data.dart';

class ProSalonInfoScreen extends StatelessWidget {
  const ProSalonInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère l'objet ProFlowData envoyé par la page compte.
    final proFlowData =
        ModalRoute.of(context)!.settings.arguments as ProFlowData;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(showBackButton: true),
          Expanded(child: ProSalonInfoWidget(proFlowData: proFlowData)),
        ],
      ),
    );
  }
}
