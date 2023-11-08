import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../model/my_user.dart';

class FirestoreDatabase {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveUserDataToFirestore(MyUserModel myUserModel) async{
    try{
      await firebaseFirestore.collection('users').doc(myUserModel.uid).set({
        'email': myUserModel.email,
        'nom': myUserModel.nom,
        'prenom': myUserModel.prenom,
      });
    }catch (error) {
      Logger().e('Error while saving user data to Firestore: $error');
    }
  }

  Future<void> updateUserDataInFirestore(MyUserModel myUserModel) async{
    try{
      await firebaseFirestore.collection('users').doc(myUserModel.uid).update({
        'email': myUserModel.email,
        'nom': myUserModel.nom,
        'prenom': myUserModel.prenom,
      });
    }catch (error) {
      Logger().e('Error while updating user data in Firestore: $error');
    }
  }

  Future<MyUserModel?> fetchUserDataFromFirestore(String? uid) async {
    if (uid == null) return null;

    final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return MyUserModel(
        uid: uid,
        email: userDoc.get('email'),
        nom: userDoc.get('nom'),
        prenom: userDoc.get('prenom'),
      );
    } else {
      return null;
    }
  }

}