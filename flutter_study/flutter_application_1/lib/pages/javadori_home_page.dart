import 'package:flutter/material.dart';

class JavadoriHomePage extends StatelessWidget {
  const JavadoriHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Javadori Home Page'),
      ),
      body: const Center(child: Text('center')),
    );
  }
}
