import 'package:flutter/material.dart';

/*
 2023.08.10
 나머지 위젯 관련

 FlutterLogo()로 화면에 플로터 로그를 보여줄수 있다.
 Icon으로 내장된 아이콘 이미지를 출력할 수 있다.
 기존에 학습했던 Image를 image 위젯을 통해서도 이미지 출력이 가능하다.
 ==> 처리하는 방식은 동일하며, Image 위젯을 먼저 만들어서 속성에 각각의 표현식을 적용하면 된다.

 Placeholder : 자리 표시자 ==> 다른 위젯이 나중에 추가될 공간에 상자를 그리는 위젯으로 개발중 인터페이스 적용에 유용하다.

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나머지 위젯 종류'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo(
              size: 100,
            ),
            Icon(Icons.accessibility_new_rounded, size: 200),
            Image(
              image: NetworkImage('https://img.montessori.co.kr/logo_200.jpg'),
            ),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
