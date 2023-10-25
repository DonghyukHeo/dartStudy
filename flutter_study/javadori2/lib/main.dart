import 'package:flutter/material.dart';
import 'package:javadori2/componets/javadori_colors.dart';
import 'package:javadori2/componets/javadori_themes.dart';
import 'package:javadori2/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: JavadoriThemes.lightTheme,
      // 기가 폰트 사이즈에 의존하지 않게 지정크기로 설정되게 할려면 builder 속성을 추가한다.
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      home: const HomePage(),
    );
  }
}
