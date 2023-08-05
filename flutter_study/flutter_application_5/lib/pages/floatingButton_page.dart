import 'package:flutter/material.dart';

/*
  FloatingActionButton 은 Scaffold 에 포함이 되어져 있으며,
  ElevatedButton 과 속성은 비슷하다.
 */
class FloatingButtonPage extends StatefulWidget {
  const FloatingButtonPage({super.key});

  @override
  State<FloatingButtonPage> createState() => _FloatingButtonPageState();
}

class _FloatingButtonPageState extends State<FloatingButtonPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플로팅 액션 버튼'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: const Icon(
          Icons.plus_one,
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text('plus'),
          ),
          Center(
            child: Text('$count'),
          )
        ],
      ),
    );
  }
}
