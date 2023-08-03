import 'package:flutter/material.dart';

/* 
  2023.08.03
  여백 스트일 위젯 (Padding, EdgeInsets)
  Padding : 안쪽 여백 설정
  
  margin : 별도의 위젯이 없으며, Container의 속성 값으로 바깥 여백을 설정
  margin에 EdgeInsets.zero 로 설정하면 여백을 없이 설정할 수 있다.
  margin에 EdgInserts.only()는 설정된 곳에만 여백을 설정하고자 할때 사용
  EdgeInsets.symmetric는 vertical 및 horizontal 요소로 여백을 설정할 때 사용

*/

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('여백 스타일 지정'),
        centerTitle: true,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     color: Colors.yellow,
      //   ),
      // ),
      body: Container(
        //margin: EdgeInsets.zero, // 여백을 없이 설정
        //margin: EdgeInsets.all(30), // top, bottom, left, right 동일한 여백을 설정
        //margin: const EdgeInsets.fromLTRB(10, 20, 30, 50), // 여백을 각각 설정할 때
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        color: Colors.green,
      ),
    );
  }
}
