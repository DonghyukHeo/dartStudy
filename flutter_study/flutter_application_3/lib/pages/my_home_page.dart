import 'package:flutter/material.dart';

/*
  2023.08.02

  복수 위젯을 담는 컨테이너 만들기 (Column, Row, Stack)
  기존에 Container를 body 영역에 하나의 위젯만 그릴 수 있지만
  복수 위젯을 그리고 싶을때 Column, Row, Stack 을 사용하여 그릴 수 있다.

  Container 는 child 위젯으로 그리지만,
  Column(Row)은 children 위젯으로 그린다.
  Stack 은 겹쳐서 위젯을 그려준다. 

  정해진 사이즈 보다 영역을 넘어설 경우 정해진 사이즈 안에 그리고 싶을 경우 Wrap으로 감싸면 된다.
  단, 방향을 정할 때는 driection 설정값으로 정해주면 된다.

  참고 : 위젯을 자동 생성할 때는 stl 까지 입력하면 선택 항목이 나온다.
 */
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('복수 위젯담기'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min, //자식 사이즈 만큼만 크기를 정한다.
        mainAxisAlignment: MainAxisAlignment.center, //위젯의 위치 설정
        crossAxisAlignment:
            CrossAxisAlignment.start, //row 영역에서 세로축에 대한 정렬 위치를 설정
        children: [
          Container(
            color: Colors.red,
            height: 20,
            child: const Text('Flutter Home 1'),
          ),
          Container(
            color: Colors.blue,
            height: 40,
            child: const Text('Flutter Home 2'),
          ),
          Container(
            color: Colors.brown,
            height: 100,
            child: const Text('Flutter Home 3'),
          ),
        ],
      ),
    );
  }
}
