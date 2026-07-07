import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class ProContactDetailsWidget extends StatefulWidget {
  const ProContactDetailsWidget({
    super.key,
    required this.category,
    required this.specialty,
  });

  final String category;
  final String specialty;

  @override
  State<ProContactDetailsWidget> createState() =>
      _ProContactDetailsWidgetState();
}

class _ProContactDetailsWidgetState extends State<ProContactDetailsWidget> {
  final TextEditingController managerController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _handleSubmit() {
    final manager = managerController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    if (manager.isEmpty || phone.isEmpty || email.isEmpty) {
      return;
    }

   Navigator.pushNamed(
  context,
  AppRoutes.proSalonInfo,
  arguments: {
    'category': widget.category,
    'specialty': widget.specialty,
    'manager': manager,
    'phone': phone,
    'email': email,
  },
);
  }

  @override
  void dispose() {
    managerController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Pourriez-vous nous fournir vos coordonnées ?',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gérant de l'établissement *",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: managerController,
                  decoration: const InputDecoration(
                    hintText: 'Ex : Antoine Martin',
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
                  'Numéro de téléphone *',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Ex : 06 86 26 44 44',
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
                  'Email *',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Ex : antoine.martin@gmail.com',
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

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Valider',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}