import 'javadori_colors.dart';
import 'package:flutter/material.dart';

/*
  2023.08.30
  
  사용자 테마 설정하기

  라이트 모드와 다크 모드를 각각 정의하여 적용을 할 수 있게 한다.
  main.dart 의 MaterialApp 에서 theme 에서 사용자 정의 class를 바라보게 하여 적용
  dart와 light의 가장 큰 차이점은 brightness 부분이다.
*/

class JavadoriThemes {
  static ThemeData get lightTheme => ThemeData(
        fontFamily: 'GmarketSansTTF',
        primarySwatch: JavadoriColors.primaryMeterialColor,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white, // 클릭시 나오는 색상
        brightness: Brightness.light, // Dart 모드일 경우에는 dark로 설정해야 한다.
        textTheme: _textTheme,
        appBarTheme: _appBarTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        fontFamily: 'GmarketSansTTF',
        primarySwatch: JavadoriColors.primaryMeterialColor,
        // scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white, // 클릭시 나오는 색상
        brightness: Brightness.dark, // Dart 모드일 경우에는 dark로 설정해야 한다.
        textTheme: _textTheme,
      );

  /*
    appBar 부분에 적용할 Theme 
    iconTheme 을 정의해서 AppBar의 CloseButton에 별도로 style을 지정하지 않고 정의한 색상으로 
    적용할 수 있다.
    elevation을 0으로 지정하면 appbar의 그림자를 없앨 수 있다.
  */
  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: JavadoriColors.primaryColor,
    ),
    elevation: 0, // appbar 그림자 제거
  );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      // color: JavadoriColors.primaryColor,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      // color: JavadoriColors.primaryColor,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      // color: JavadoriColors.primaryColor,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      // color: JavadoriColors.primaryColor,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      // color: JavadoriColors.primaryColor,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      // color: JavadoriColors.primaryColor,
    ),
  );
}
