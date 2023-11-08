
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';

ThemeData lightThemeData(BuildContext context){
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kWhiteColor,
    appBarTheme: appBarTheme,
    textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme)
      .apply(
      displayColor: kDarkPrimaryColor,
      bodyColor: kDarkPrimaryColor
    )
  );
}

ThemeData darkThemeData(BuildContext context){
  return ThemeData.light().copyWith(
      primaryColor: kWhiteColor,
      scaffoldBackgroundColor: kDarkPrimaryColor
  );
}

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
  iconTheme: IconThemeData(color: kWhiteColor)
);