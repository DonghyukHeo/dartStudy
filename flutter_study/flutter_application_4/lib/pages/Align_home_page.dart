import 'package:flutter/material.dart';

/*
  화면의 폭 크기 : MediaQuery.of(context).size.width 로 폭을 알 수 있다.
  Spacer : 각 요소를 그린 이 후 남은 공간을 여백으로 처리를 해준다.
  spacer에 flex 값을 설정해서 전체 여백 공간에 대비해서 여백의 크기를 지정해 줄 수 있다.
  (flex 값 / flex 총합 으로 계산)
*/
class AlignHomePage extends StatelessWidget {
  const AlignHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('배치 및 공간 제어'),
        centerTitle: true,
      ),
      // body: Align(
      //   alignment: Alignment.center,
      //   child: Container(
      //     color: Colors.blue,
      //     height: 200,
      //     width: 150,
      //   ),
      // ),
      body: Row(
        children: [
          Container(
            color: Colors.yellow,
            height: 40,
            width: 40,
          ),
          Container(
            color: Colors.green,
            height: 40,
            width: 40,
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            color: Colors.blue,
            height: 40,
            width: 40,
          ),
          const Spacer(
            flex: 1,
          ),
          Container(
            color: Colors.green,
            child: const Text('Javadori'),
          ),
          // SizedBox(
          //   height: 40,
          //   width: MediaQuery.of(context).size.width - (40 * 5),
          // ),
          const Spacer(), //요소를 다 그린 이후 남은 공간의 여백을 그려준다.
          Container(
            color: Colors.purple,
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }
}
