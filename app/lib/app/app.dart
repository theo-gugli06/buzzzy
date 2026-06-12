import 'package:flutter/material.dart';

import 'routes.dart';

class BuzzzyApp extends StatelessWidget {
  const BuzzzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzzzy',
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
