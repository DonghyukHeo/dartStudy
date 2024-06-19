import 'package:flutter/material.dart';

/*
  Color 설정 하기

  colors 값에서(0xFF151515) 0xFF 제외한 숫자가 colors의 hex 코드이다.
  MaterialApp 에서 사용하는 ThemeData 에서 사용될 MaterialColor 값을 정의
  폰트의 스케일 값을 50 ~ 900까지 정의한다.

*/
class JavadoriColors {
  static const int _primaryColorValue = 0xFF151515;
  static const primaryColor = Color(_primaryColorValue);

  static const MaterialColor primaryMeterialColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(_primaryColorValue),
      100: Color(_primaryColorValue),
      200: Color(_primaryColorValue),
      300: Color(_primaryColorValue),
      400: Color(_primaryColorValue),
      500: Color(_primaryColorValue),
      600: Color(_primaryColorValue),
      700: Color(_primaryColorValue),
      800: Color(_primaryColorValue),
      900: Color(_primaryColorValue),
    },
  );
}
