import 'package:flutter/material.dart';

// Colos that use in our app
const kSecondaryColor = Color(0xFF1872c9);
const kTextColor = Color(0xFF12153D);
const kTextLightColor = Color(0xFFcce6ff);
const kFillStarColor = Color(0xFFFCC419);
const kMaincolor = Color(0xFF0054a5);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(1, 5),
  blurRadius: 4,
  color: Colors.black26,
);

final themePP = ThemeData(
  textTheme: TextTheme(
      headline3: TextStyle(fontFamily: 'DinPro', fontWeight: FontWeight.w700),
      bodyText1: TextStyle(fontFamily: 'DinPro', fontWeight: FontWeight.w400),
      bodyText2: TextStyle(fontFamily: 'DinPro', fontWeight: FontWeight.w300),
      caption: TextStyle(fontFamily: 'DinPro', fontWeight: FontWeight.w200)),
  primaryColorDark: const Color(0xFF0097A7),
  primaryColorLight: const Color(0xFF00c5b3),
  primaryColor: const Color(0xFF000000),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

// class PPtheme with Diagnosticable{
// const TextTheme ({TextStyle dinProBold, TextStyle dinProMedium, TextStyle dinProRegular, TextStyle dinProLight,

// }): assert((dinProBold == null && dinProMedium == null && dinProRegular == null && dinProLight == null)); final TextStyle dinProBold; final TextStyle dinProMedium; final TextStyle dinProRegular; final TextStyle dinProLight; };

const textInputDecoration = InputDecoration(
    focusColor: kMaincolor,
    hoverColor: kSecondaryColor,
    suffixStyle: TextStyle(
        fontFamily: "DimPro",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: kMaincolor),
    labelStyle: TextStyle(
        fontFamily: "DimPro",
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: kMaincolor));
