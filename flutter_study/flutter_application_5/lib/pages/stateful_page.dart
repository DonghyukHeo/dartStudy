import 'package:flutter/material.dart';

/*
  2023.08.07
  
  동적 화면 그리기 

  StatefulWidget 위젯 사용하기
  화면이 변경될 경우 build를 다시 호출할 수 있도록 해야 된다.
  setState 을 통해서 다시 build 하여 화면이 변경이 되도록 한다.

  참고, stf 로 작성하면 StatefulWidget을 선택하여 생성할 수 있다.
 */

class StateFulPage extends StatefulWidget {
  StateFulPage({super.key});

  @override
  State<StateFulPage> createState() => _StateFulPageState();
}

class _StateFulPageState extends State<StateFulPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동적화면 그리기'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              print('ElevatedButton');
              //count++;
              print(count);
              setState(() {
                count++;
              }); //화면을 다시 build가 되도록 호출
            },
            child: const Text('plus'),
          ),
          Center(
            child: Text('$count'),
          ),
          Javadori(),
        ],
      ),
    );
  }
}

class Javadori extends StatefulWidget {
  const Javadori({super.key});

  @override
  State<Javadori> createState() => _JavadoriState();
}

class _JavadoriState extends State<Javadori> {
  @override
  Widget build(BuildContext context) {
    return const Text('Javadori');
  }
}
