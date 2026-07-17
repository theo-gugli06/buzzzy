// Modèle utilisé uniquement côté front pour transporter les données
// entre les différentes étapes du parcours pro.
class ProFlowData {
  const ProFlowData({
    // Données obligatoires du parcours.
    required this.category,
    required this.specialty,
    required this.accountMode,
    required this.email,

    // Données optionnelles : elles existent surtout
    // quand l'utilisateur crée un compte.
    this.firstname,
    this.lastname,
    this.userPhone,
    this.password,
    this.confirmPassword,
  });

  final String category;
  final String specialty;

  // Indique si l'utilisateur vient d'une création de compte ou d'une connexion.
  // Exemple : "create" ou "login".
  final String accountMode;

  final String email;

  // Le "?" veut dire que ces valeurs peuvent être null.
  // Elles sont présentes en création de compte
  final String? firstname;
  final String? lastname;
  // Telephone du compte utilisateur.
  final String? userPhone;
  final String? password;

  final String? confirmPassword;
}
