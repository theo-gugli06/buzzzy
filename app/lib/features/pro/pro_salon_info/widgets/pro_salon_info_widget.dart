import 'package:flutter/material.dart';

class ProSalonInfoWidget extends StatefulWidget {
  const ProSalonInfoWidget({
    super.key,

    // Données obligatoires : elles sont toujours envoyées
    // depuis les pages précédentes.
    required this.category,
    required this.specialty,
    required this.accountMode,
    required this.email,

    // Données optionnelles : elles existent surtout
    // quand l'utilisateur crée un compte.
    this.firstname,
    this.lastname,
    this.phone,
    this.password,
  });

  final String category;
  final String specialty;

  // Permet de savoir si l'utilisateur vient du formulaire
  // de création de compte ou du formulaire de connexion.
  final String accountMode;

  // Email obligatoire, car il est envoyé dans les deux cas :
  // création de compte et connexion.
  final String email;

  // Valeurs optionnelles.
  // Le "?" veut dire que la valeur peut être null.
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? password;

  @override
  State<ProSalonInfoWidget> createState() => _ProSalonInfoWidgetState();
}

class _ProSalonInfoWidgetState extends State<ProSalonInfoWidget> {
  // Controllers = objets qui permettent de lire ce que l'utilisateur tape.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // _handleSubmit = gérer la validation du formulaire
  // Cette fonction est appelée quand l'utilisateur clique sur Valider
  void _handleSubmit() {
    // final c 'est une variable qu'on initialise une fois et qu'on ne modifie plus.
    // Ici on récupère les textes tapés dans les champs
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postalCode = postalCodeController.text.trim();
    final country = countryController.text.trim();

    // Si un champ obligatoire est vide on stoppe la fonction
    if (name.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        postalCode.isEmpty ||
        country.isEmpty) {
      return;
    }

    final salonData = {
      // Données choisies au début du parcours pro.
      'category': widget.category,
      'specialty': widget.specialty,

      // Indique si l'utilisateur a créé un compte ou s'est connecté.
      'accountMode': widget.accountMode,

      // Données du compte.
      'firstname': widget.firstname,
      'lastname': widget.lastname,
      'phone': widget.phone,
      'email': widget.email,
      'password': widget.password,

      // Données du salon saisies sur cette page.
      'name': name,
      'description': description,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };

    print(salonData);
  }

  @override
  void dispose() {
    // On libère les controllers quand le widget disparaît.
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
