import 'package:flutter/material.dart';
import 'package:flutter_hive_sample/model/inputform.dart';
import 'package:flutter_hive_sample/page/user_list_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();

  runApp(const MyApp());
}

// Hive 초기화
Future<void> _initHive() async {
  await Hive.initFlutter();

  //Hive.registerAdapter<InputForm>(InputFormAdapter());
  Hive.registerAdapter(InputFormAdapter());

  await Hive.openBox('darkModeBox');
  await Hive.openBox<InputForm>('inputFormBox');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const UserListPage(),
    );
  }
}
