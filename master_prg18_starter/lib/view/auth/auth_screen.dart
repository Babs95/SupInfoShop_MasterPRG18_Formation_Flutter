import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/utls.dart';
import 'package:master_prg18_starter/firestore_database/firestore_database.dart';
import 'package:master_prg18_starter/model/my_user.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../state_controller/provider/authentification_service.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _myAuthFormKey = GlobalKey<FormState>();
  final AuthentificationService authService = AuthentificationService();
  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  String? errorMessage = '';
  bool isLogin = true;
  bool isLoading = false;
  bool hidePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Authentification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _myAuthFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email'
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return ('L\'email est requis.');
                        }else if(!Utils.validateEmail(value.trim())) {
                          return ('Veuillez saisir un email valide.');
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                            hidePassword ? Icons.visibility_off : Icons.visibility,
                            color: kPrimaryColor,
                          ),
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return ('Le mot de passe est requis.');
                        }
                        return null;
                      },
                    ),
                    Visibility(
                      visible: !isLogin,
                      child: TextFormField(
                        controller: _nomController,
                        decoration: const InputDecoration(
                            labelText: 'Nom'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return ('Le nom est requis.');
                          }
                          return null;
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isLogin,
                      child: TextFormField(
                        controller: _prenomController,
                        decoration: const InputDecoration(
                            labelText: 'Prénom'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return ('Le prénom est requis.');
                          }
                          return null;
                        },
                      ),
                    ),
                    Visibility(
                      visible: errorMessage != '',
                      child: Text(
                        'Humm error: $errorMessage'
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_myAuthFormKey.currentState!.validate()){
                          Logger().i('Formulaire valide');
                          isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
                        }else{
                          Logger().i('Formulaire non valide');
                        }
                      }, child: Text(isLogin ? 'Se Connecter' : 'S\'inscrire'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      }, child: Text(isLogin ? 'Je crée un compte' : 'Je me connecte'),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Utils.loader(),
              )
            ],
          ),
        ),
      ),
    );
  }

  //=====================================ACTIONS=======================================//
  Future<void> signInWithEmailAndPassword() async{
    try {
      setState(() {
        isLoading = true;
      });

       await authService.signInWithEmailAndPassword(
         email: _emailController.text,
         password: _passwordController.text
       );

       MyUserModel? myUserModel = await firestoreDatabase.fetchUserDataFromFirestore(authService.user?.uid);

       if(myUserModel != null) {
         Provider.of<AuthentificationService>(context, listen: false).setMyUserConnected(myUserModel);
       }

      Toast.show(
        'Vous êtes connecté !',
        duration: 4,
        gravity: Toast.top,
        backgroundColor: kGreenColor
      );

      setState(() {
        isLoading = false;
        errorMessage = '';
      });

      Navigator.of(context).pop();

    }on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage =  e.message;
        isLoading = false;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try {
      setState(() {
        isLoading = true;
      });

      await authService.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );

      MyUserModel myUserModel = MyUserModel(
        uid: authService.user?.uid,
        email: authService.user?.email,
        nom: _nomController.text,
        prenom: _prenomController.text
      );

      await firestoreDatabase.saveUserDataToFirestore(myUserModel);

      Toast.show(
          'Votre compte a été crée avec succès!',
          duration: 4,
          gravity: Toast.top,
          backgroundColor: kGreenColor
      );

      setState(() {
        isLoading = false;
        isLogin = true;
        _emailController.clear();
        _passwordController.clear();
        errorMessage = '';
      });

    }on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage =  e.message;
        isLoading = false;
      });
    }
  }
}