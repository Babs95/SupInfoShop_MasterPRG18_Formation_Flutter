import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/commons/utls.dart';
import 'package:master_prg18_starter/model/my_user.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../firestore_database/firestore_database.dart';
import '../../state_controller/provider/authentification_service.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MyUserModel? myUserModel;
  final _myUserInfosFormKey = GlobalKey<FormState>();
  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  bool loading = false;
  bool onUpate = false;

  @override
  void initState() {
    myUserModel = Provider.of<AuthentificationService>(context, listen: false).myUserModel;
    _nomController.text = myUserModel?.nom ?? '';
    _prenomController.text = myUserModel?.prenom ?? '';
    super.initState();
  }
  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          myUserInfos(myUserModel!),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _myUserInfosFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                        labelText: 'Nom'
                    ),
                    onChanged: (text) => onInfosChange(),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return ('Le nom est requis.');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(
                        labelText: 'Prénom'
                    ),
                    onChanged: (text) => onInfosChange(),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return ('Le prénom est requis.');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0,),
                  ElevatedButton(
                    onPressed: !onUpate || loading
                        ? null : _updateUserInfosBtnAction,
                    child: const Text('Enregistrer les modifications'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //============================ ACTIONS ==================================
  _updateUserInfosBtnAction() async {
    setState(() {
      loading = true;
      onUpate = true;
    });

    myUserModel?.setNom = _nomController.text;
    myUserModel?.setPrenom = _prenomController.text;

    await firestoreDatabase.updateUserDataInFirestore(myUserModel!);

    MyUserModel? user = await firestoreDatabase.fetchUserDataFromFirestore(myUserModel?.uid);

    if(user != null) {
      Provider.of<AuthentificationService>(context, listen: false).setMyUserConnected(user);
      setState(() {
        loading = false;
        onUpate = false;
      });

      Toast.show(
          'Vos informations ont été modifiées avec succès !',
          duration: 4,
          gravity: Toast.top,
          backgroundColor: kGreenColor
      );
    }
  }


  onInfosChange() {
    Logger().i('called');
    if(_nomController.text.isEmpty || _prenomController.text.isEmpty){
      setState(() => onUpate = false);
    }else if(!Utils.compareStrings(_nomController.text, myUserModel?.nom ?? '') ||
        !Utils.compareStrings(_prenomController.text, myUserModel?.prenom ?? '')) {
      setState(() => onUpate = true);
    }else{
      setState(() => onUpate = false);
    }
  }
  //============================ VIEWS ==================================+
  Widget myUserInfos(MyUserModel userModel) {
    String sigleUser = userModel.prenom != null  && userModel.nom != null
                      ? "${userModel.prenom?.substring(0,1)}${userModel.nom?.substring(0,1)}"
                      :"";
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kPrimaryColor,
        child: AutoSizeText(
          sigleUser.toUpperCase(),
          maxLines: 1,
          style: TextStyle(
            fontSize: SizeConfig.isTablet ? 30 : 20,
            color: kWhiteColor
          ),
        ),
      ),
      title: Text(
        "${userModel.prenom} ${userModel.nom}",
        style: TextStyle(
            fontSize: SizeConfig.isTablet ? 30 : 20,
            color: kDeepDarkPrimaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        userModel.email ?? '',
        style: const TextStyle(
            color: kPrimaryColor,
        ),
      ),
    );
  }
}