import 'package:flutter/material.dart';
import 'package:master_prg18_starter/state_controller/provider/authentification_service.dart';
import 'package:master_prg18_starter/view/acceuil/acceuil_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../app_drawer_screen.dart';
import '../commons/size_config.dart';

class PrincipalScreen extends StatefulWidget {
  static const String routeName = '/principal';
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ToastContext().init(context);
    return Consumer<AuthentificationService>(builder: (context, model, child){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          centerTitle: true,
        ),
        drawer: AppDrawerScreenState(isUserLogin: model.myUserModel != null,),
        body: AccueilScreen(myUserModel: model.myUserModel),
      );
    });
  }
}