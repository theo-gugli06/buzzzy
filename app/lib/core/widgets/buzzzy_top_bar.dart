import 'package:flutter/material.dart';
import '../../app/routes.dart';

class BuzzzyTopBar extends StatelessWidget {
  const BuzzzyTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Le Container extérieur met le fond blanc jusque sous la zone système
    // du téléphone (heure, batterie, réseau).
    return Container(
      color: Colors.white,

      // SafeArea empêche le contenu de passer sous la zone système.
      // Le fond reste blanc grâce au Container extérieur.
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),

              const Expanded(
                child: Center(
                  child: Text(
                    'buzzzy',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}