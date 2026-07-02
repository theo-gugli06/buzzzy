import 'package:flutter/material.dart';

class ProLandingWidget extends StatelessWidget {
  const ProLandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        const Text(
          'Devenir partenaire Buzzzy Pro',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Plus tard : navigation vers création salon
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                side: const BorderSide(color: Colors.black, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 245),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Je suis gérant d'un établissement",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Coiffure, esthétique, barber, bien-être...',
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Plus tard : navigation vers création salon
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                side: const BorderSide(color: Colors.black, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 245),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Je ne suis pas professionnel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Je souhaite prendre un rendez-vous beauté',
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
