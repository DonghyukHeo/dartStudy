import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:javadori/components/javadori_themes.dart';
import 'package:javadori/pages/home_page.dart';
import 'package:javadori/repositories/javadori_hive.dart';
import 'package:javadori/repositories/medicine_history_repository.dart';
import 'package:javadori/repositories/medicine_repository.dart';
import 'package:javadori/services/javadori_notification_service.dart';

final notification = JavadoriNotification();
// Hive
final hive = JavadoriHive();
final medicineRepository = MedicineRepository();
final historyRepository = MedicineHistoryRepository();

void main() async {
  // notification 을 위한 초기화 처리
  WidgetsFlutterBinding.ensureInitialized();

  // 날짜정보의 local data 정보를 사용하기 위해서 초기화 처리
  await initializeDateFormatting();
  await notification.initializeTimeZone();
  await notification.initializeNotification();

  /*
    hive 가 open 되지 않은 상태에서 runApp이 동작되었을 경우
    hive에 접근을 하면 에러가 발생이 된다.
    그래서 await 처리를 한다.
    Future 타입으로 선언
  */
  await hive.initializeHive();

  runApp(const MyApp());
}

/*
  2023.08.28 
  
  프로젝트 폴더 구조 설정
  components : 버튼, 컬러, 사이즈, 테마, 라우트 애니메이션 설정
  config : hive box name 등 정의
  models : 모델 데이터 정의 - custom objects 
  repositories : hive CRUD - DB를 추가/삭제/수정 등의 작업 (services 부분에서 가공 후 DB 처리 부분만 처리)
  pages : 페이지 - 화면 뷰 부분(UI)
  services : 서비스 로직 - 화면 뷰 부분에서 실행되는 처리 부분의 로직(작업처리)
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: JavadoriThemes.lightTheme, // 사용자 정의 테마 적용
      // 폰트 사이즈를 기기에 의존하지 않고 처리하고자 하면 아래 코드 적용
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      home: HomePage(),
    );
  }
}

/*
  2023.08.29 

  커스텀 폰트 설정
  구글(https://fonts.google.com), 눈누(https://noonnu.cc/index)

  루트에 assets 폴더에 폰트 추가
  pubspec.yaml 파일에서 fonts 부분 주석해제 후 수정 
  전체에 폰트는 적용하고자 할때 ThemeData에 fontFamily 를 해당 폰트명을 지정하면 된다.

*/
/*
  Linter : 코드를 개선하는데 도움을 주는 도구 (프로그램 오류, 버그 스타일 오류 등을 체크 후 알려주는 도구)
  analysis_options.yaml 파일에 package:flutter_lints/flutter.yaml 을 include 하여 자동으로 적용되어져 있다.
  rules 에서 심각도를 사용자 정의로 수정하여 적용할 수 있으나 권장되지는 않는다.
*/

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
