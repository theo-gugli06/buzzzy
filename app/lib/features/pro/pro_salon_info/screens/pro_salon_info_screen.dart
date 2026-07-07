import 'package:flutter/material.dart';

import '../../../../core/widgets/buzzzy_top_bar.dart';
import '../widgets/pro_salon_info_widget.dart';

class ProSalonInfoScreen extends StatelessWidget {
  const ProSalonInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          BuzzzyTopBar(),
         Expanded(
            child: ProSalonInfoWidget(),
         ),
        ],
      ),
    );
  }
}