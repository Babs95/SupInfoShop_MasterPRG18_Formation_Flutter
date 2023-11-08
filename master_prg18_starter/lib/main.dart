import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/state_controller/provider/authentification_service.dart';
import 'package:master_prg18_starter/view/acceuil/acceuil_screen.dart';
import 'package:master_prg18_starter/view/auth/auth_screen.dart';
import 'package:master_prg18_starter/view/onboarding/onboarding_screen.dart';
import 'package:master_prg18_starter/view/principal_screen.dart';
import 'package:master_prg18_starter/view/produit/produit_screen.dart';
import 'package:master_prg18_starter/view/profile/profile_screen.dart';
import 'package:master_prg18_starter/view/routes/routes.dart';
import 'package:master_prg18_starter/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'commons/constant_string.dart';
import 'commons/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark
  ));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthentificationService()),
        StreamProvider<User?>.value(value: AuthentificationService().authStageChanges, initialData: null)
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: const SplashScreen(),
      routes: {
        Routes.principal: (BuildContext context) => const PrincipalScreen(),
        Routes.home: (BuildContext context) => const AccueilScreen(),
        Routes.onboarding: (BuildContext context) => const OnBoardingScreen(),
        Routes.produit: (BuildContext context) => const ProduitScreen(),
        Routes.auth: (BuildContext context) => const AuthScreen(),
        Routes.profile: (BuildContext context) => const ProfileScreen(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const AccueilScreen(),
        );
      },
    );
  }

}
