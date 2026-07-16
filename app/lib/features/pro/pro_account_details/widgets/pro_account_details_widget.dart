import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
import '../../shared/models/pro_flow_data.dart';

class ProAccountDetailsWidget extends StatefulWidget {
  const ProAccountDetailsWidget({super.key, required this.proFlowData});

  final ProFlowData proFlowData;

  @override
  State<ProAccountDetailsWidget> createState() =>
      _ProAccountDetailsWidgetState();
}

class _ProAccountDetailsWidgetState extends State<ProAccountDetailsWidget> {
  // Controllers utilisés pour lire le texte saisi dans les champs.
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Champs liés au mot de passe du compte pro.
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // false = formulaire de création de compte
  // true = formulaire de connexion
  bool isLoginMode = false;

  @override
  void dispose() {
    // On libère les controllers quand l'écran disparaît.
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void _handleCreateAccountSubmit() {
    // On récupère le texte saisi dans chaque champ.
    final firstname = firstnameController.text.trim();
    final lastname = lastnameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Si un champ obligatoire est vide, on bloque la suite.
    if (firstname.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }

    // La confirmation sert seulement à vérifier que le mot de passe est bien saisi.
    if (password != confirmPassword) {
      return;
    }

    // On continue vers les infos du salon avec les données déjà choisies.
    Navigator.pushNamed(
      context,
      AppRoutes.proSalonInfo,
      arguments: ProFlowData(
        category: widget.proFlowData.category,
        specialty: widget.proFlowData.specialty,
        accountMode: 'create',
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        email: email,
        password: password,
      ),
    );
  }

  // vérifie seulement que les champs ne sont pas vides.
  void _handleLoginSubmit() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    // Plus tard, ici on appellera l'API login.
    Navigator.pushNamed(
      context,
      AppRoutes.proSalonInfo,
      arguments: ProFlowData(
        category: widget.proFlowData.category,
        specialty: widget.proFlowData.specialty,
        accountMode: 'login',
        email: email,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // SingleChildScrollView permet de scroller si le formulaire dépasse l'écran.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Aligne les éléments de la colonne à gauche.
        children: [
          const SizedBox(height: 40),

          Padding(
            // Ajoute une marge à gauche et à droite.
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              // Si isLoginMode vaut true, on affiche le titre de connexion.
              // Sinon, on affiche le titre du formulaire de création de compte.
              isLoginMode
                  ? 'Connectez-vous à votre compte'
                  : 'Vos informations',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 30),

          // Le "!" inverse la valeur : false devient true.
          // Donc ici, le bloc s'affiche quand on n'est pas en mode connexion.
          if (!isLoginMode) ...[
            _AccountTextField(
              label: 'Prénom *',
              hintText: 'Ex : Antoine',
              controller: firstnameController,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Nom *',
              hintText: 'Ex : Martin',
              controller: lastnameController,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Téléphone *',
              hintText: 'Ex : 06 86 26 44 44',
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Email *',
              hintText: 'Ex : antoine.martin@gmail.com',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Mot de passe *',
              hintText: 'Votre mot de passe',
              controller: passwordController,
              obscureText: true,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Confirmation du mot de passe *',
              hintText: 'Confirmez votre mot de passe',
              controller: confirmPasswordController,
              obscureText: true,
            ),

            const SizedBox(height: 30),
          ],

          // Affiche les champs de connexion seulement quand isLoginMode vaut true.
          if (isLoginMode) ...[
            _AccountTextField(
              label: 'Email *',
              hintText: 'Ex : antoine.martin@gmail.com',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            _AccountTextField(
              label: 'Mot de passe *',
              hintText: 'Votre mot de passe',
              controller: passwordController,
              obscureText: true,
            ),

            const SizedBox(height: 30),
          ],

          const SizedBox(height: 15),

          Padding(
            // Même marge horizontale que les champs du formulaire.
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              // Le bouton prend toute la largeur disponible.
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                // Si on est en mode connexion on appelle la fonction login.
                // Sinon, on appelle la fonction création de compte.
                onPressed: isLoginMode
                    ? _handleLoginSubmit
                    : _handleCreateAccountSubmit,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: Text(
                  // Le texte du bouton change selon le mode.
                  isLoginMode ? 'Se connecter' : 'Continuer',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Padding(
            // Ajoute une marge à gauche et à droite du bouton.
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: SizedBox(
              // Le bouton prend toute la largeur disponible.
              width: double.infinity,
              height: 54,

              child: OutlinedButton(
                // Code exécuté quand on clique sur le bouton.
                onPressed: () {
                  // setState dit à Flutter
                  // "une valeur a changé reconstruis l'affichage".
                  setState(() {
                    // On inverse le mode actuel.
                    // false devient true : on passe en connexion.
                    // true devient false : on revient en création de compte.
                    isLoginMode = !isLoginMode;
                  });
                },

                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: Text(
                  // Si isLoginMode est true, on est sur le formulaire de connexion,
                  // donc on propose de créer un compte.
                  // Sinon, on est sur le formulaire d'inscription,
                  // donc on propose de se connecter.
                  isLoginMode
                      ? 'Pas encore de compte ? Créer un compte'
                      : 'Déjà un compte ? Se connecter',

                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Champ de formulaire réutilisable pour la page compte.
class _AccountTextField extends StatelessWidget {
  const _AccountTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  // Texte affiché au-dessus du champ.
  final String label;

  // Exemple affiché en gris dans le champ.
  final String hintText;

  // Controller utilisé pour lire ce que l'utilisateur écrit.
  final TextEditingController controller;

  // Type de clavier : texte, email, téléphone...
  final TextInputType? keyboardType;

  // true = cache le texte, utile pour les mots de passe.
  final bool obscureText;

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
            obscureText: obscureText,
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
