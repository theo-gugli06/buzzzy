import 'package:app/core/widgets/buzzzy_top_bar.dart';
import 'package:flutter/material.dart';
import '../../../app/routes.dart';

import '../services/auth_api_service.dart';
import '../services/auth_session_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _handleRegister() async {
    // Recupere les valeurs tapees dans le formulaire.
    final firstname = firstnameController.text.trim();
    final lastname = lastnameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Stoppe l'inscription si un champ obligatoire est vide.
    if (firstname.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }

    try {
      // Cree le compte via l'API et recupere la reponse avec le JWT.
      final data = await AuthApiService.register(
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone.isEmpty ? null : phone,
        password: password,
        confirmPassword: confirmPassword,
      );

      // Stocke le token pour garder l'utilisateur connecte.
      final token = data['accessToken'] as String;
      await AuthSessionService.saveToken(token);

      if (!mounted) return;

      // Remplace la page register par la home client.
      Navigator.pushReplacementNamed(context, AppRoutes.clientHome);
    } catch (error) {
      if (!mounted) return;

      // Affiche l'erreur renvoyee par l'API.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Contenu scrollable de la page.
        SingleChildScrollView(
          // Décale le formulaire vers le bas pour qu'il ne soit pas caché
          // derrière la top bar fixe.
          padding: const EdgeInsets.only(top: 105),
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Text(
                'Nouveau sur Buzzzy ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prénom *',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: firstnameController,
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
                      'Nom *',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: lastnameController,
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
                      'Email *',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                      'Téléphone',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
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
                      'Confirmation du mot de passe *',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 3),

                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
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

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Créer mon compte',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Color(0xFFDADADA), thickness: 1),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'ou',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),

                    const Expanded(
                      child: Divider(color: Color(0xFFDADADA), thickness: 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Déjà un compte ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),

        // Top bar fixée au-dessus du contenu scrollable.
        const Positioned(top: 0, left: 0, right: 0, child: BuzzzyTopBar()),
      ],
    );
  }
}
