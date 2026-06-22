import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  // Adresse de base de l'API NestJS.
  static const String baseUrl = 'http://localhost:3000';

  // Envoie email + mot de passe à l'API pour connecter l'utilisateur.
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // Construit l'URL complète de la route de connexion.
    final url = Uri.parse('$baseUrl/auth/login');

    // Envoie une requête POST avec les identifiants au format JSON.
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // Transforme la réponse JSON de l'API en données Dart.
    final data = jsonDecode(response.body);

    // Si l'API ne répond pas avec succès, on lance une erreur.
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erreur de connexion');
    }

    // Retourne message, accessToken, user, etc.
    return data;
  }

  // Envoie les informations d'inscription à l'API.
  static Future<Map<String, dynamic>> register({
    required String firstname,
    required String lastname,
    required String email,
    String? phone,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phone': phone,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erreur d inscription');
    }

    return data;
  }

  // Vérifie le token JWT et récupère le profil de l'utilisateur connecté.
  static Future<Map<String, dynamic>> getMe({required String token}) async {
    // Construit l'URL complète de la route protégée /auth/me.
    final url = Uri.parse('$baseUrl/auth/me');

    // Envoie le token dans le header Authorization.
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    // Transforme la réponse JSON de l'API en données Dart.
    final data = jsonDecode(response.body);

    // Si le token est invalide ou expiré, on lance une erreur.
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Session invalide');
    }

    // Retourne le profil utilisateur.
    return data;
  }
}
