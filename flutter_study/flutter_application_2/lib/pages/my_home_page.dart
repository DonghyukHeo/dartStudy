// 해당 부분을 위젯이라고 부른다.
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Flutter App Bar'))),
      body: Container(
          color: Colors.yellow,
          // 자식이 없는 상태에서 폭과 높이를 지정하면 지정된 부분까지만 처리
          // width: 500,
          // height: 200,

          // alignment.center 로 설정할 경우 여백과 상관 없이 전체 화면에서 중앙 정렬을 시킨다.
          // 즉 화면에 그릴 수 있는 영역에서 정렬 처리가 된다.
          alignment: Alignment.center,

          //padding 바깥 여백
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          // margin 안쪽 여백
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
          ),
          child: const Text('Javadori Main')),
    );
  }
}
