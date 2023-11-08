import 'package:master_prg18_starter/view/onboarding/onboarding_screen.dart';
import 'package:master_prg18_starter/view/principal_screen.dart';
import 'package:master_prg18_starter/view/profile/profile_screen.dart';

import '../acceuil/acceuil_screen.dart';
import '../auth/auth_screen.dart';
import '../produit/produit_screen.dart';

class Routes {
  static const String principal =  PrincipalScreen.routeName;
  static const String home =  AccueilScreen.routeName;
  static const String onboarding =  OnBoardingScreen.routeName;
  static const String produit =  ProduitScreen.routeName;
  static const String auth =  AuthScreen.routeName;
  static const String profile =  ProfileScreen.routeName;
}