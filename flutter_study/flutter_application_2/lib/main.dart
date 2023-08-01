import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/my_home_page.dart';

/*
  2023.08.01

  위젯을 별도로 처리를 할 경우 _로 시작하는 위젯은 private 위젯으로 설정이 되기 때문에
  별도의 파일로 구현을 할 경우 접근을 할 수 없다.
  별도의 파일로 접근할 하게 할 경우 _ 없이 public 위젯으로 구현을 해야 한다.

  padding 바깥 여백
  margin 안쪽 여백
  alignment.center 로 설정할 경우 child가 없는 것 처럼 container가 그릴 수 있는 전체를 기준으로 정렬시킨다.
  Alignment(x, y)로 세부 설정이 가능하며, (0, 0) 이 center 이다. (그래프 좌표 형태로 적용)
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
      title: 'My App Bar',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}
