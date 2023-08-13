import 'package:flutter/material.dart';
import 'package:flutter_package_study/page/home_page.dart';

/*
  별도 패키지를 설치하여 설정할 경우
  pubspec.yaml 파일에 관련 내용을 작성하며, 해당 내용을 작성할 경우
  dependencies 부분에 작성해야 한다.
  dev_dependencies 부분은 개발시 잠시 사용하기 위해 정의하는 부분이다.

  패키지를 삽입하여 동작이 안될 경우 앱을 재실행하여 동작시켜 본다.
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}
