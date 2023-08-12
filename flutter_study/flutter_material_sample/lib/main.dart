import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const ButtonApp(),
    );
  }
}

/* 
  2023.08.11

  하단 네이게이션바 만들기
  bottomNavigationBar 속성으로 하단에 메뉴를 만들며, BottomNavigationBar 위젯에 items에 
  리스트 형태의 자료형을 넣어야 한다.
  BottomNavigationBarItem 에 icon이 required로 선언이 되어져 있어 반드시 작성해야 하며,
  label은 required는 아니지만 null 값이 들어가면 에러가 발생하기 때문에 작성을 해야
  정상적으로 화면에 출력이 된다.
  currentIndex 값으로 활성화 할 기본 메뉴를 정할 수 있다.

  쿠퍼티노 iOS스타일은 네이티브 위젯이 아니다. 
*/

class ButtonApp extends StatefulWidget {
  const ButtonApp({super.key});

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  int _index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text('Bottom 네이게이션 바'),
        centerTitle: true,
      ),
      */
      appBar: const CupertinoNavigationBar(
        middle: Text('쿠퍼티노 스타일 AppBar'),
      ),
      body: const Center(
        //child: CupertinoActivityIndicator(),
        child: CupertinoSearchTextField(
          prefixIcon: Icon(CupertinoIcons.search),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (value) => setState(() {
                _index = value;
              }),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'ac_unit',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'alarm',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'star',
            ),
          ]),
    );
  }
}
