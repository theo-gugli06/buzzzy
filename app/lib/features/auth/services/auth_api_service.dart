import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  // Adresse de base de l'API NestJS.
  static const String baseUrl = 'http://localhost:3000';

  // Fonction qui envoie email + mot de passe à l'API pour connecter l'utilisateur.
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // Construit l'URL complète de la route de connexion.
    final url = Uri.parse('$baseUrl/auth/login');

    // Envoie une requête POST à l'API avec les identifiants au format JSON.
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Transforme la réponse JSON de l'API en données utilisables par Dart.
    final data = jsonDecode(response.body);

    // Si l'API ne renvoie pas un code de succès, on lance une erreur.
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erreur de connexion');
    }

    // Si la connexion réussit, on retourne la réponse complète :
    // message, accessToken, user, etc.
    return data;
  }
}
