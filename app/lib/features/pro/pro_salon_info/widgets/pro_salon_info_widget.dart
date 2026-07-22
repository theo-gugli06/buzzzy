import 'package:flutter/material.dart';
import '../../shared/models/pro_flow_data.dart';

import '../../services/pro_salon_api_service.dart';

import '../../../../app/routes.dart';

class ProSalonInfoWidget extends StatefulWidget {
  const ProSalonInfoWidget({super.key, required this.proFlowData});

  // Données récupérées depuis les étapes précédentes du parcours pro.
  final ProFlowData proFlowData;

  @override
  State<ProSalonInfoWidget> createState() => _ProSalonInfoWidgetState();
}

class _ProSalonInfoWidgetState extends State<ProSalonInfoWidget> {
  // Controllers = objets qui permettent de lire ce que l'utilisateur tape.
  final TextEditingController salonPhoneController = TextEditingController();
  final TextEditingController salonEmailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // Indique si l'appel API est en cours.
  bool isLoading = false;

  // _handleSubmit = gérer la validation du formulaire
  // Cette fonction est appelée quand l'utilisateur clique sur Valider
  Future<void> _handleSubmit() async {
    // final c 'est une variable qu'on initialise une fois et qu'on ne modifie plus.
    // Ici on récupère les textes tapés dans les champs
    final salonPhone = salonPhoneController.text.trim();
    final salonEmail = salonEmailController.text.trim();
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postalCode = postalCodeController.text.trim();
    final country = countryController.text.trim();

    final salonPhoneRegex = RegExp(r'^[0-9]{10}$');

    // Si un champ obligatoire est vide on stoppe la fonction
    if (name.isEmpty ||
        salonPhone.isEmpty ||
        salonEmail.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        postalCode.isEmpty ||
        country.isEmpty) {
      return;
    }

    // Si le téléphone du salon ne respecte pas le format attendu,
    // on affiche une erreur et on bloque l'envoi à l'API.
    if (!salonPhoneRegex.hasMatch(salonPhone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le téléphone du salon doit contenir 10 chiffres'),
        ),
      );

      return;
    }

    final salonData = {
      'category': widget.proFlowData.category,
      'specialty': widget.proFlowData.specialty,
      'accountMode': widget.proFlowData.accountMode,
      'firstname': widget.proFlowData.firstname,
      'lastname': widget.proFlowData.lastname,
      'userPhone': widget.proFlowData.userPhone,
      'userEmail': widget.proFlowData.userEmail,
      'password': widget.proFlowData.password,
      'confirmPassword': widget.proFlowData.confirmPassword,

      // Données du salon saisies sur cette page.
      'name': name,
      'description': description,
      'salonPhone': salonPhone,
      'salonEmail': salonEmail,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };

    setState(() {
      isLoading = true;
    });

    try {
      // On tente d'envoyer les données du salon à l'API.
      // On stocke la réponse renvoyée par l'API.
      // Elle contient par exemple le message, le user créé et le salon créé.
      final result = await ProSalonApiService.createProSalon(
        salonData: salonData,
      );

      if (!mounted) return;

      // Si l'API a réussi, on remplace le formulaire par la page pro home.
      // On envoie aussi les infos utiles pour afficher un message personnalisé.
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.proHome,
        arguments: {
          'message': result['message'],
          'salonName': result['salon']['name'],
          'firstname': result['user']['firstname'],
        },
      );
    } catch (error) {
      // Si l'API renvoie une erreur, on récupère le message.
      // replaceFirst enlève le "Exception: " pour afficher un message plus propre.
      final errorMessage = error.toString().replaceFirst('Exception: ', '');

      if (!mounted) return;

      // Affiche le message d'erreur en bas de l'écran.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      // Ce bloc s'exécute toujours, que l'appel API réussisse ou échoue.
      // On vérifie que le widget existe encore avant d'appeler setState.
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // On libère les controllers quand le widget disparaît.
    salonPhoneController.dispose();
    salonEmailController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
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
              'Parlez-nous de votre salon',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 30),

          _SalonTextField(
            label: 'Nom du salon *',
            hintText: 'Ex : Salon Martin',
            controller: nameController,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Description',
            hintText: 'Ex : Coiffure, barber, soins...',
            controller: descriptionController,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Téléphone du salon *',
            hintText: 'Ex : 06 00 00 00 00',
            controller: salonPhoneController,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Email du salon *',
            hintText: 'Ex : contact@salon-martin.fr',
            controller: salonEmailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Adresse *',
            hintText: 'Ex : 12 rue de Paris',
            controller: addressController,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Ville *',
            hintText: 'Ex : Paris',
            controller: cityController,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Code postal *',
            hintText: 'Ex : 75001',
            controller: postalCodeController,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 15),

          _SalonTextField(
            label: 'Pays *',
            hintText: 'Ex : France',
            controller: countryController,
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Valider',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _SalonTextField extends StatelessWidget {
  const _SalonTextField({
    required this.label, //le titre au dessus du champ
    required this.hintText, //l’exemple gris dans le champ
    required this.controller, //le controller qui récupère le texte
    this.keyboardType,
  });

  // Petit widget réutilisable pour éviter de répéter le même TextField 6 fois
  final String label;
  final String hintText;
  final TextEditingController
  controller; // Controller relié au TextField pour récupérer le texte tapé.
  final TextInputType?
  keyboardType; // Type de clavier à afficher, par exemple numérique pour le code postal.
  // Le ? veut dire que cette valeur est optionnelle.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 6),

          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
