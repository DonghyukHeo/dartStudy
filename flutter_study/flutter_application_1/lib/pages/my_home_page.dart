// 해당 부분을 위젯이라고 부른다.
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App Bar')),
      body: const Text('Javadori Main'),
    );
  }
}
