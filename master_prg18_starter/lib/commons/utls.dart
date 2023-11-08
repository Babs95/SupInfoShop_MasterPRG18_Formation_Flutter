import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/size_config.dart';

import 'constant_string.dart';

class Utils{
  static bool isPortrait(BuildContext context) {
    return SizeConfig.orientation == Orientation.portrait;
  }

  static Future<bool> isTablet(BuildContext context) async {
    if(Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfos = await deviceInfo.iosInfo;
      return iosInfos.model?.toLowerCase() == "ipad";
    }else {
      var shortestSide = MediaQuery.of(context).size.shortestSide;
      return shortestSide > 600;
    }
  }
  static Widget loader() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: kPrimaryColor,
          valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  static bool validateEmail(String value) {
    RegExp regExp =  RegExp(patternEmail);
    return regExp.hasMatch(value) ? true : false;
  }

  static bool compareStrings(String string1, String string2){
    return string1.toLowerCase() == string2.toLowerCase();
  }
}