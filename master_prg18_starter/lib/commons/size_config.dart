import 'package:flutter/cupertino.dart';
import 'package:master_prg18_starter/commons/utls.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0.0;
  static double screenWidth1 = 0.0;
  static double screenWidth5 = 0.0;
  static double screenWidth10 = 0.0;
  static double screenWidth15 = 0.0;
  static double screenWidth20 = 0.0;
  static double screenWidth25 = 0.0;
  static double screenWidth30 = 0.0;
  static double screenWidth35 = 0.0;
  static double screenWidth40 = 0.0;
  static double screenWidth45 = 0.0;
  static double screenWidth50 = 0.0;
  static double screenWidth55 = 0.0;
  static double screenWidth60 = 0.0;
  static double screenWidth65 = 0.0;
  static double screenWidth70 = 0.0;
  static double screenWidth75 = 0.0;
  static double screenWidth80 = 0.0;
  static double screenWidth85 = 0.0;
  static double screenWidth90 = 0.0;
  static double screenWidth95 = 0.0;

  static double screenHeight = 0.0;
  static double screenHeight1 = 0.0;
  static double screenHeight5 = 0.0;
  static double screenHeight10 = 0.0;
  static double screenHeight15 = 0.0;
  static double screenHeight20 = 0.0;
  static double screenHeight25 = 0.0;
  static double screenHeight30 = 0.0;
  static double screenHeight35 = 0.0;
  static double screenHeight40 = 0.0;
  static double screenHeight45 = 0.0;
  static double screenHeight50 = 0.0;
  static double screenHeight55 = 0.0;
  static double screenHeight60 = 0.0;
  static double screenHeight65 = 0.0;
  static double screenHeight70 = 0.0;
  static double screenHeight75 = 0.0;
  static double screenHeight80 = 0.0;
  static double screenHeight85 = 0.0;
  static double screenHeight90 = 0.0;
  static double screenHeight95 = 0.0;
  static double defaultSize = 0.0;
  static Orientation orientation = Orientation.portrait;
  static bool isTablet = false;

  /*sizeConfigFonc(BuildContext context){
    init(context);
  }
*/
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    Utils.isTablet(context).then((value) => isTablet = value);

    screenWidth1 = screenWidth * 0.01;
    screenWidth5 = screenWidth * 0.05;
    screenWidth10 = screenWidth * 0.1;
    screenWidth15 = screenWidth * 0.15;
    screenWidth20 = screenWidth * 0.20;
    screenWidth25 = screenWidth * 0.25;
    screenWidth30 = screenWidth * 0.3;
    screenWidth35 = screenWidth * 0.35;
    screenWidth40 = screenWidth * 0.4;
    screenWidth45 = screenWidth * 0.45;
    screenWidth50 = screenWidth * 0.5;
    screenWidth55 = screenWidth * 0.55;
    screenWidth60 = screenWidth * 0.6;
    screenWidth65 = screenWidth * 0.65;
    screenWidth70 = screenWidth * 0.7;
    screenWidth75 = screenWidth * 0.75;
    screenWidth80 = screenWidth * 0.8;
    screenWidth85 = screenWidth * 0.85;
    screenWidth90 = screenWidth * 0.9;
    screenWidth95 = screenWidth * 0.95;

    screenHeight1 = screenHeight * 0.01;
    screenHeight5 = screenHeight * 0.05;
    screenHeight10 = screenHeight * 0.1;
    screenHeight15 = screenHeight * 0.15;
    screenHeight20 = screenHeight * 0.20;
    screenHeight25 = screenHeight * 0.25;
    screenHeight30 = screenHeight * 0.3;
    screenHeight35 = screenHeight * 0.35;
    screenHeight40 = screenHeight * 0.4;
    screenHeight45 = screenHeight * 0.45;
    screenHeight50 = screenHeight * 0.5;
    screenHeight55 = screenHeight * 0.55;
    screenHeight60 = screenHeight * 0.6;
    screenHeight65 = screenHeight * 0.65;
    screenHeight70 = screenHeight * 0.7;
    screenHeight75 = screenHeight * 0.75;
    screenHeight80 = screenHeight * 0.8;
    screenHeight85 = screenHeight * 0.85;
    screenHeight90 = screenHeight * 0.9;
    screenHeight95 = screenHeight * 0.95;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getHeightAppbar(BuildContext context) {
  return Utils.isPortrait(context)
      ? SizeConfig.screenHeight * 0.13
      : SizeConfig.screenHeight * 0.17;
}

bool isLandScapeScreen(){
  return SizeConfig.orientation == Orientation.landscape;
}