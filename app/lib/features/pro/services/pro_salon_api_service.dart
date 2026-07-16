import 'dart:convert';
import 'package:http/http.dart' as http;

class ProSalonApiService {
  // Adresse de base de l'API NestJS en local.
  static const String baseUrl = 'http://localhost:3000';

  // Envoie les données du parcours pro à l'API.
  static Future<Map<String, dynamic>> createProSalon({
    required Map<String, dynamic> salonData,
  }) async {
    // Route API qui recevra les données du salon.
    final url = Uri.parse('$baseUrl/pro/salons');

    // Envoie une requête POST avec les données converties en JSON.
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(salonData),
    );

    // Convertit la réponse JSON de l'API en Map Dart.
    final data = jsonDecode(response.body);

    // Si l'API répond avec une erreur, on bloque et on renvoie un message.
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erreur lors de la création du salon');
    }

    // Si tout va bien, on retourne la réponse de l'API.
    return data;
  }
}