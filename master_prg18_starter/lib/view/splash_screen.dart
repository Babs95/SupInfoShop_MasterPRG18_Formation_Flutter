import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/view/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/config.dart';
import '../commons/constant_assets.dart';
import '../commons/constant_colors.dart';
import '../commons/constant_string.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();

}

class SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  setPref() async {
    prefs = await SharedPreferences.getInstance();
    startTime();
  }

  startTime(){
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigation);
  }

  navigation(){
    Navigator.pushReplacementNamed(context,
        prefs?.getBool(FIRST_TIME) == null
            ? Routes.onboarding
            : Routes.principal
    );
  }

  @override
  void initState() {
    Config().init(context);
    setPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSplashBackgroundGreyColor,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 5),
            child: Center(
              child: Image(
                image: const AssetImage(KImageSplashScreen),
                width: getProportionateScreenWidth(400),
                height: getProportionateScreenHeight(500),
              ),
            ),
          )
        ],
      ),
    );
  }

}