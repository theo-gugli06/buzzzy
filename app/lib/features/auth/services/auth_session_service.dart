import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSessionService {
  // Stockage sécurisé du téléphone pour garder le token JWT.
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Clé utilisée pour enregistrer et retrouver le token.
  static const String _accessTokenKey = 'accessToken';

  // Enregistre le token après une connexion réussie.
  static Future<void> saveToken(String token) async {
    await _storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  // Récupère le token stocké, ou null si aucun token n'existe.
  static Future<String?> getToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  // Supprime le token, utile pour la déconnexion.
  static Future<void> clearToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  // Indique rapidement si un token est présent.
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}