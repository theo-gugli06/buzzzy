import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class ProEstablishmentTypeWidget extends StatelessWidget {
  const ProEstablishmentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Quel établissement souhaitez-vous équiper ?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.proEstablishmentDetails,
                  arguments: 'hair',
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                side: const BorderSide(color: Colors.black, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Salon de coiffure ou barbershop',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.black, size: 24),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.proEstablishmentDetails,
                  arguments: 'beauty',
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                side: const BorderSide(color: Colors.black, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Institut de beauté, spa ou bar à ongles',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.black, size: 24),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.proEstablishmentDetails,
                  arguments: 'wellness',
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                side: const BorderSide(color: Colors.black, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Professionnels du bien-être',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.black, size: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
