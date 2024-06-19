import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], //핑크 배경색 설정
      body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            // 위아래 끝에 위젯 배치
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // 반대축 최대 크기로 늘리기
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DDay(
                // 하트 눌렀을 때 실행할 함수 전달하기
                onHeartPressed: onHeartPressed,
                firstDay: firstDay,
              ),
              _CoupleImage(),
            ],
          )),
    );
  }

  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter, //아래 중앙으로 정렬
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true, //외부에 탭할 경우 다이얼로그 닫기
    );

    // setState(() {
    //   firstDay = firstDay.subtract(Duration(days: 1)); // 하루 씩 빼기
    // });
  }
}

class _DDay extends StatelessWidget {
  // 하트를 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const _DDay({
    super.key,
    required this.onHeartPressed,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    //테마 불러오기
    final textThem = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          'U&I',
          style: textThem.headlineLarge,
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 사랑을 약속한 날',
          style: textThem.bodyMedium,
        ),
        Text(
          // '2007.06.03',
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textThem.bodySmall,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          // 'D+365',
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textThem.headlineMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  const _CoupleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          //화면 크기의 반만큼 높이 설정
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
