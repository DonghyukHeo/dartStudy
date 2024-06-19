import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

/*
  TabBarView 는 TabController가 필수이며, TabController를 초기화 하려면 vsync기능이 필요하다.
  그러기 위해서는 State위젯에 TickerProviderMixin을 mixin으로 제공해줘야 한다.
  TabController 위젯은 생성될 때 단 한번만 초기화를 해줘야 하기 때문에 initState 에서 초기화 해준다.
 */
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller; // TabController 선언
  double threshold = 2.7; // 민감도 기본값 설정
  int number = 1; // 주사위 기본 숫자

  //Shake 플러그인
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); //컨트롤러 초기화
    //컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    controller!.addListener(tabListener);

    //흔들기 감지
    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100, // 감지 주기
      shakeThresholdGravity: threshold, // 감지 민감도
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller, //컨트롤러 등록
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab 1',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange)
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab 2',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // )
    ];
  }

  // 리스터 함수
  tabListener() {
    setState(() {});
  }

  @override
  dispose() {
    controller!.removeListener(tabListener); //리스너에 등록된 함수 등록 취소 처리
    shakeDetector!.stopListening(); // 흔들기 감지 중지
    super.dispose();
  }

  //슬라이더값 변경 시 실행 함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  // 흔들기 감지 후 실행 함수
  void onPhoneShake() {
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  // Bottom 내비게이션
  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index, //현재 화면에 랜더링되는 탭의 인덱스
      onTap: (int index) {
        //BottomNavigationBar의 선택 index 값을 넘겨서 TabBarView 화면 인덱스 변경
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }
}
