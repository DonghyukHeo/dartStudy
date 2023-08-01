import 'package:flutter/material.dart';
//import 'package:flutter_application_1/pages/javadori_home_page.dart';
import 'package:flutter_application_1/pages/my_home_page.dart';

/*
  기본적으로 body 영역이 전체 화면을 구성하고 있다.
  화면을 기본 구성하는 부분은 Scaffold 로 감싸줘야 한다.
  화면상은 body 부분에서 처리를 한다.
  기본적으로 body, appbar, text 를 먼저 공부한다.

  StatelessWidget 위젯은 build 위젯을 기반으로 화면을 그린다.

  함수 및 위젯를 코드로 바로 이동은 control + click (command + click)을 누르면 된다. 
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      //home: const JavadoriHomePage(), //화면에 보여줄 위젯을 호출
      home: const MyHomePage(),
    );
  }
}
