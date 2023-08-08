import 'package:flutter/material.dart';

/* 
  2023.08.08 

  StatelessWidget 에서 StatefulWidget으로 전환은 
  호출 명령으로 바로 전환이 가능하나 반대로
  StatefulWidget 에서 StatelessWidget 전환은 자동 전환이 되지 않기 때문에
  개별적으로 수정을 해줘야 한다.

  위젯간에 데이터를 전달할때는 파라미터 필드를 final로 선언을 한 후
  생성자에서 입력을 받을 수 있게 정의해야 한다.

*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(name: 'Javadori'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.name});

  final String name;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello ${widget.name} World',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Hello ${widget.name} World',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
