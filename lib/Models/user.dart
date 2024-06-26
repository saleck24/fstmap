class User {
  String nom;
  String prenom;
  String email;
  String genre;

  User(
      {required this.nom, required this.prenom, required this.email, required this.genre});
  // Méthode pour convertir User en un objet JSON (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'genre': genre,
    };
  }
}

