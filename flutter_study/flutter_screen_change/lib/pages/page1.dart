import 'package:flutter/material.dart';
import 'package:flutter_screen_change/pages/page2.dart';

/*
  화면을 이동하기 위해서는
  Navigator.push 을 사용하여 이동할 페이지를 지정한다.
  이동된 페이지에서는 뒤로 가기 버튼이 자동으로 추가가 되어서 화면에 표시가 된다.

  
 */

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page1'),
      ),
      body: Column(
        children: [
          Text(
            'hello',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Page2(),
                ),
              );
            },
            child: const Text('page2로 이동'),
          )
        ],
      ),
    );
  }
}
