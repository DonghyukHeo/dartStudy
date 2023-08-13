import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingPage extends StatefulWidget {
  const EasyLoadingPage({super.key});

  @override
  State<EasyLoadingPage> createState() => _EasyLoadingPageState();
}

class _EasyLoadingPageState extends State<EasyLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyLoading 패키지 사용하기'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              EasyLoading.show(status: 'loading...');
            },
            child: const Text('Btn'),
          ),
          const Center(
            child: Text('버튼을 눌러보세요.'),
          ),
        ],
      ),
    );
  }
}
