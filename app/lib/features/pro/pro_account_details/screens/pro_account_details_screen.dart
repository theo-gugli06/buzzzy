import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_account_details_widget.dart';
import '../../shared/models/pro_flow_data.dart';

class ProAccountDetailsScreen extends StatelessWidget {
  const ProAccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère l'objet ProFlowData envoyé par la page spécialité.
    final proFlowData =
        ModalRoute.of(context)!.settings.arguments as ProFlowData;
    // ModalRoute.of(context)! récupère la route actuelle.
    // settings.arguments récupère les données envoyées à cette page.
    // as ProFlowData indique que ces données sont un objet ProFlowData.
    
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const BuzzzyTopBar(showBackButton: true),
          Expanded(
            child: ProAccountDetailsWidget(
              // On envoie l'objet complet au widget.
              proFlowData: proFlowData,
            ),
          ),
        ],
      ),
    );
  }
}
