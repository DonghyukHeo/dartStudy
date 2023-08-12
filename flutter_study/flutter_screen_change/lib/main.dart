import 'package:flutter/material.dart';
import 'package:flutter_screen_change/pages/page1.dart';
// import 'package:flutter_screen_change/pages/page2.dart';
// import 'package:flutter_screen_change/pages/page3.dart';

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
      home: const Page1(),
    );
  }
}
