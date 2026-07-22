import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
import '../../shared/models/pro_flow_data.dart';

class ProEstablishmentDetailsWidget extends StatelessWidget {
  const ProEstablishmentDetailsWidget({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final specialties = switch (category) {
      'hair' => ['Salon de coiffure', 'Barbershop', 'Coiffure et barber'],
      'beauty' => [
        'Institut de beauté multi-services',
        'Bar à ongles',
        'Cils et sourcils',
        'Spa / soins du corps',
      ],
      'wellness' => [
        'Massage / relaxation',
        'Réflexologie',
        'Sophrologie',
        'Coaching bien-être',
      ],
      _ => ['Autre'],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Quelle est votre spécialité principale ?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),

        const SizedBox(height: 30),

        ...specialties.map(
          (specialty) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.proAccountDetails,
                    arguments: ProFlowData(
                      category: category,
                      specialty: specialty,
                      accountMode: '',
                      userEmail: '',
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  specialty,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
