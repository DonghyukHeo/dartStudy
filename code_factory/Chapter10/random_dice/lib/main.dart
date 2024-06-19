import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';
import 'package:random_dice/screen/root_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        // Slider 위젯 테마
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, //노브 색상
          activeTrackColor: primaryColor, // 노브가 이동한 트랙 색상
          inactiveTrackColor:
              primaryColor.withOpacity(0.3), // 노브가 아직 이동하지 않은 트랙 색상
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor, //선택 상태 색
          unselectedItemColor: secondaryColor, //비 선택 상태 색
          backgroundColor: backgroundColor, //배경색
        ),
      ),
      home: const RootScreen(),
    ),
  );
}
