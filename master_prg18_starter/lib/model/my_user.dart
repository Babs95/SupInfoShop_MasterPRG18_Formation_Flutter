class MyUserModel {
  String? _uid;
  String? _email;
  String? _password;
  String? _nom;
  String? _prenom;


  String? get uid => _uid;
  String? get email => _email;
  String? get password => _password;
  String? get nom => _nom;
  String? get prenom => _prenom;

  set setNom(String nom) {
    _nom = nom;
  }

  set setPrenom(String prenom) {
    _prenom = prenom;
  }

  set setEmail(String email) {
    _email= email;
  }

  MyUserModel({
    String? uid,
    String? email,
    String? password,
    String? nom,
    String? prenom
  }) {
      _uid = uid;
      _email = email;
      _password = password;
      _nom = nom;
      _prenom = prenom;
    }
}