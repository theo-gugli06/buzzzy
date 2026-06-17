// Widget qui contiendra le formulaire de connexion.
import 'package:app/core/widgets/buzzzy_top_bar.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BuzzzyTopBar(),

        const SizedBox(height: 30),

        const Text(
          'Vous avez déjà utilisé Buzzzy ?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email *',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 3),

              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mot de passe *',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 3),

              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.black, fontSize: 16, decoration: TextDecoration.underline),
             
              ),
            ),
          ),
        ),
      ],
    );
  }
}
