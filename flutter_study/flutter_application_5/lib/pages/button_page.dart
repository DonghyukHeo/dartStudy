import 'package:flutter/material.dart';

/*
  2023.08.04
  버튼 사용하기

  onPressed, child는 반든시 사용되어야 되는 항목이므로 처리를 해줘야 한다.
  단, GestureDetector 는 onTap로 처리된다.
  ElevatedButton, OutlinedButton, TextButton 위젯은 속성 값이 동일하다.
  버튼의 기본 스타일은 MaterialApp 의 ThemeData에 의해서 설정이 되지만
  개별적인 버튼 스타일을 줘서 변경할 수 있다.
  단, 버튼의 child에 속성 값을 별도로 적용하는 것은 추천하지 않는다.

  버튼이 비활성화 된것을 표현하고자 할때는 onPress에 null로 설정하면 된다.

 */
class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('버튼 사용하기'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print('ElevatedButton Press');
            },
            onLongPress: () {
              print('onLongPress');
            },
            child: const Text('ElevatedButton'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print('ElevatedButton Press 2');
                },
                onLongPress: () {
                  print('onLongPress 2');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  //onPrimary: Colors.white, // 텍스트 색상 설정
                  foregroundColor: Colors.white, // 텍스트 색상 설정
                ),
                child: const Text('ElevatedButton 2'),
              ),
              ElevatedButton(
                onPressed: null,
                onLongPress: null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  //onPrimary: Colors.white, // 텍스트 색상 설정
                  foregroundColor: Colors.white, // 텍스트 색상 설정
                  //onSurface: Colors.purple,
                  disabledForegroundColor: Colors.purple,
                ),
                child: const Text('ElevatedButton 2'),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  print('OutlinedButton Press');
                },
                style: OutlinedButton.styleFrom(
                  //backgroundColor: Colors.blue,
                  foregroundColor: Colors.red,
                ),
                child: const Text('OutlinedButton'),
              ),
              OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                  //backgroundColor: Colors.blue,
                  foregroundColor: Colors.red,
                ),
                child: const Text('OutlinedButton'),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              print('TextButton Press');
            },
            child: const Text('TextButton'),
          ),
          GestureDetector(
            onTap: () {},
            onTapDown: (details) {
              print('GestureDetector ${details.globalPosition}');
            },
            child: const Text('GestureDetector'),
          ),
        ],
      ),
    );
  }
}
