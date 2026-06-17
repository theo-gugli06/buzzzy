import 'package:flutter/material.dart';

import '../widgets/home_hero_section.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     backgroundColor: Color.fromARGB(255, 255, 255, 255),
     body: HomeHeroSection(),
    );
  }
}