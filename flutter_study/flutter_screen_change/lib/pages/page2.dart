import 'package:flutter/material.dart';
import 'package:flutter_screen_change/pages/page3.dart';

/*
  push로 호출된 페이지에서 나가기 위해서는 Navigator.pop을 사용하여 나갈 수 있다.
 */
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            print('close button click');
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'page2 hello',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Page3(),
                  ));
            },
            child: const Text('next page3'),
          )
        ],
      ),
    );
  }
}
