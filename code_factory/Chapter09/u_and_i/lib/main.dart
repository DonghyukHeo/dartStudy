import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 70.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'parisienne',
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    home: HomeScreen(),
  ));
}
