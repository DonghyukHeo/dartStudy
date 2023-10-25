import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:javadori/components/javadori_colors.dart';
import 'package:javadori/components/javadori_constants.dart';
import 'package:javadori/components/javadori_widgets.dart';

/*
  2023.09.22

  TimePicker를 개별적 파일로 분리하여 처리
  TimePicker에서 시간 선택시 전달을 위하여 
  Navigator.pop 을 통해서 결과 값을 전달하도록 구현

  2023.10.04
  시간 선택부분의 버튼을 다른곳에서도 사용할 수 있도록 버튼의 타이틀을
  변경이 가능하도록 class에 submit 버튼의 이름을 지정하도록 기능 개선
  기본값은 '선택' 이 나오도록 처리
  복약 시간을 지우기 위한 버튼 위젯 추가 처리
*/
class TimeSettingBottomSheet extends StatelessWidget {
  const TimeSettingBottomSheet({
    super.key,
    // required this.initialDateTime,
    required this.initialTime,
    this.submitTitle = '선택',
    this.bottomWidget,
    // required this.service,
  });

  // final DateTime initialDateTime;
  final String initialTime;
  // final AddMedicineService service;
  final Widget? bottomWidget;
  final String submitTitle;

  @override
  Widget build(BuildContext context) {
    final initialTimeData =
        DateFormat('HH:mm').parse(initialTime); // 받은 time 값이 String 이기 때문에 형 변환
    final now = DateTime.now();
    final initialDateTime = DateTime(now.year, now.month, now.day,
        initialTimeData.hour, initialTimeData.minute);
    DateTime setDateTime = initialDateTime; //TimePicker 에서 선택한 값을 받아올 변수

    return BottomSheetBody(
      children: [
        /*
          CupertinoDatePicker 를 사용할 때는 size를 지정하지 않으면 오류가 발생한다.
          그렇게 때문에 SizedBox로 height를 설정하여 size를 지정처리한다.
        */
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time, // 시간만 선택하게 설정
            initialDateTime: initialDateTime, // 초기 값을 설정하기 위한 속성
          ),
        ),
        const SizedBox(
          height: smallSpace,
        ),
        if (bottomWidget != null) bottomWidget!,
        const SizedBox(height: smallSpace),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                    backgroundColor: Colors.white,
                    foregroundColor: JavadoriColors.primaryColor,
                    // primary: Colors.white,
                    // onPrimary: Colors.black,
                  ),
                  child: const Text('취소'),
                ),
              ),
            ),
            const SizedBox(
              width: smallSpace,
            ),
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    // service.setAlarm(
                    //   prevTime: initialTime,
                    //   setTime: _setDateTime ?? initialDateTime,
                    // );

                    //Navigator.pop 을 통해서 결과 값을 전달하도록 처리
                    Navigator.pop(context, setDateTime);
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                  child: Text(submitTitle),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
