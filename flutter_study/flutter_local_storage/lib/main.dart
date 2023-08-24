import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_storage/page/user_list_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

/*
  2023.08.23
  
  로컬 저장소 hive 이용하기

  로컬 데이터 베이스
  NoSQL Database
  순수 Dart로 작성된 키-값(key-value) 데이터베이스
  앱을 위한 가벼운 데이터 저장소로 적합하다.

  hive에서 저장된 모든 데이터는 Box로 구성되어져 있다.
  Box는 SQL의 Table과 비교할 수 있지만 구조가 없으며 무엇이든 포함이 가능하다.
  민감한 데이터를 저장할 때 Box를 암호화 할 수 있다.

  Model Adapters를 사용하기 위해서는 아래 정보를 pubspec.yaml에 작성해야 한다.
  dev_dependencies:
    hive_generator: ^[version]
    build_runner: ^[version]  

  hive를 이용하기 위해서는 runApp 하기 전에 Hive를 초기화 해야 한다.
  모든 데이터를 Box에 사용하기 위해서는 반드시 openBox를 최초 한번은 열어야 하며,
  앱이 종료되기 전에 Hive.Close() 해줘야 한다.
*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(const MyApp());
}

// Hive 초기화
Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('darkModeBox');
}

/*
  2023.08.24 

  Hive를 통해서 dark모드 전환 구현
  설정에 따라서 hive box에 값을 put 처리 한후
  설정된 box의 값을 get올 가져와서 설정을 반영한다.
  dark 모드는 build 부분의 setState 로는 반영이 안되며, 
  box의 값이 변화 될때 해당 정보를 가지고 처리를 하기 위한 listner가 필요하다.
  listener는 ValueListenableBuilder 를 통해서 구현을 처리하여 MaterialApp에 적용이 되도록
  하면 된다.
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //변경된 것을 반영하기 위해서는 ValueListenableBuilder 를 통해서 hive의 box를 listenable 처리해야 한다.
    return ValueListenableBuilder(
      valueListenable: Hive.box('darkModeBox').listenable(),
      builder: (context, Box box, widget) {
        // box를 object 타입으로 Box 형식으로 전달
        final darkMode =
            box.get('mode', defaultValue: false); // hive box에 값을 가져오기
        return MaterialApp(
          title: 'Flutter Demo',
          //themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: const UserListPage(),
        );
      },
    );
  }
}
