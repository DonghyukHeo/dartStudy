import 'package:flutter/material.dart';
import 'package:javadori2/componets/javadori_colors.dart';

class JavadoriThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: JavadoriColors.primaryMeterialColor,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        fontFamily: 'GmarketSansTTF',
        brightness: Brightness.light,
        textTheme: _textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: JavadoriColors.primaryMeterialColor,
        splashColor: Colors.white,
        fontFamily: 'GmarketSansTTF',
        brightness: Brightness.dark,
        textTheme: _textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );
}
