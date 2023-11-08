import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:master_prg18_starter/view/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../model/my_user.dart';

class AuthentificationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  MyUserModel? _myUserModel;

  User? get user => _user;
  MyUserModel? get myUserModel => _myUserModel;

  Stream<User?> get authStageChanges => _auth.authStateChanges();

  AuthentificationService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  void setMyUserConnected(MyUserModel? myUserModel){
    _myUserModel = myUserModel;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password
  }) async{
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut(BuildContext context, {
    String message ="Vous êtes déconnecté", bool backToHome = true}) async{

    Provider.of<AuthentificationService>(context, listen: false).setMyUserConnected(null);

    await _auth.signOut();

    Toast.show(
        message,
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
    );

    Navigator.pushNamedAndRemoveUntil(context, Routes.principal, (route) => false);
  }
}