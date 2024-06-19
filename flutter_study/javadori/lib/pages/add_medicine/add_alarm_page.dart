import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:javadori/components/javadori_colors.dart';
import 'package:javadori/components/javadori_constants.dart';
import 'package:javadori/components/javadori_widgets.dart';
import 'package:javadori/main.dart';
import 'package:javadori/models/medicine.dart';
//import 'package:javadori/pages/add_medicine/add_medicine_page.dart';
import 'package:javadori/pages/add_medicine/components/add_page_widget.dart';
import 'package:javadori/services/add_medicine_service.dart';
import 'package:javadori/services/javadori_file_service.dart';

import '../bottomsheet/time_setting_bottomsheet.dart';
// import 'package:permission_handler/permission_handler.dart';

/*
  2023.09.08

  등록 화면에서 데이터 등록 버튼 클릭 시 결과 알림을 표시하기 위한 페이지 

  이미지 및 약 이름을 받아서 화면에 출력
  등록 페이지에서 입력한 정보를 listview 형태로 뿌려주기 구현
*/
// ignore: must_be_immutable
class AddAlarmPage extends StatelessWidget {
  AddAlarmPage(
      {super.key,
      required this.medicienImage,
      required this.medicineName,
      required this.updateMedicineId}) {
    service = AddMedicineService(updateMedicineId);
  }

  final int updateMedicineId; //수정시 필요한 id 값
  final File? medicienImage;
  final String medicineName;

//   @override
//   State<AddAlarmPage> createState() => _AddAlarmPageState();
// }

// class _AddAlarmPageState extends State<AddAlarmPage> {
  // 중복 체크가 필요하며, 열거를 해야 함으로 set 형식으로 지정
  // final _alarms = <String>{
  //   '08:00',
  //   '13:00',
  //   '18:00',
  // };

  //final service = AddMedicineService(updateMedicineId); //서비스 객체
  late AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          // medicienImage == null ? Container() : Image.file(medicienImage!),
          // Text(medicineName),
          Text(
            '매일 복약 잊지말아요!',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: largeSpace,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: service,
              /* 
              AnimatedBuilder의 builder는 context와 widget를 받는데, 
              widget을 사용하지 않기 때문에 _ 대체 처리한다.

              AnimatedBuilder를 통해서  ChangeNotifier의 notifyListeners()를 호출되면
              builder를 통해서 매번 새롭게 그려진다.
              */
              builder: (context, _) {
                return ListView(
                  children: alarmWidgets,
                  // children: ,
                  // const [
                  //   AlarmBox(),
                  //   AddAlarmButton(),
                  // ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () async {
          final isUpdate = updateMedicineId != -1;

          isUpdate
              ? await _onUpdateMedicine(context)
              : await _onAddMedicine(context);
        },
        text: '완료',
      ),
    );
  }

  Future<void> _onAddMedicine(BuildContext context) async {
    /*
            1. add alarm
            2. save image (로컬 디렉토리 : 갤러리가 아니라 폴더에 파일로 저장)
            3. add medicine model (local DB, hive)
          */

    // add alarm 하기 전에 권한이 없을 경우 스냅바를 띄우도록 처리
    // 개별 함수로 분리 javadori_widgets.dart (showPermissionDenied)
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //       //duration: Duration(),
    //       content: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text('알림 권한이 없습니다.'),
    //       TextButton(
    //         // onPressed: () {
    //         //   openAppSettings(); //설정창으로 이동
    //         // },
    //         onPressed: openAppSettings,
    //         child: Text('설정창으로 이동'),
    //       )
    //     ],
    //   )),
    // );

    //알람 추가
    // 알람이 하나가 아니기 때문에 service.alarms 의 값을 가져와서 반복 처리
    bool result = false;

    for (var alarm in service.alarms) {
      result = await notification.addNotification(
        medicineId: medicineRepository.newId,
        alarmTimeStr: alarm,
        title: '$alarm 약 먹을 시간이에요!',
        body: '$medicineName 복약했다고 알려주세요!',
      );
    }
    log(1);
    if (!result) {
      // ignore: use_build_context_synchronously
      return showPermissionDenied(context, permission: '알람');
    }

    // 2. save image (로컬 디렉토리 : 갤러리가 아니라 폴더에 파일로 저장)
    String? imageFilePath;
    if (medicienImage != null) {
      imageFilePath = await saveImageToLocalDirectory(medicienImage!);
    }

    // 3. add medicine model (local DB, hive)
    final medicine = Medicine(
      id: medicineRepository.newId,
      name: medicineName,
      imagePath: imageFilePath,
      // alarms: service.alarms,
      alarms: service.alarms.toList(),
    );

    medicineRepository.addMedicine(medicine);

    /*
          완료 버튼을 터치하여 등록후 페이지를 나가게 할때
          Navigator.pop(context);
          을 하면 이전 페이지로 돌아가게 된다.
          페이지가 여러개로 걸쳐 있는 경우
          Navigator.popUntil 으로 처리
          */
    // Navigator.pop(context);
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.popUntil(context, (route) => route.isFirst);
  }

  /*
    2023.10.17
    수정을 위한 별도의 매서드 생성
    알람 추가전에 반드시 기존의 알람 및 이미지(변경 체크)를 전체 삭제 처리를 먼저하도록 한다.
  */

  // 수정시 처리 부분
  Future<void> _onUpdateMedicine(BuildContext context) async {
    /*
            1-1. delete previous alarm
            1-2. add alarm
            2-1. delete previous image 
            2-2. save image (로컬 디렉토리 : 갤러리가 아니라 폴더에 파일로 저장)
            3. update medicine (local DB, hive)
    */

    // 1-1 기존 알람 삭제 처리
    final alarmIds = _updateMedicine.alarms
        .map((alarmTime) => notification.alarmId(updateMedicineId, alarmTime));
    await notification.deleteMultipleAlarm(alarmIds);

    // 1-2 알람 추가
    // medicineId에 새로운 값이 아닌 기존 meidcineId 값으로 처리
    // 알람이 하나가 아니기 때문에 service.alarms 의 값을 가져와서 반복 처리
    bool result = false;

    for (var alarm in service.alarms) {
      result = await notification.addNotification(
        medicineId: updateMedicineId,
        alarmTimeStr: alarm,
        title: '$alarm 약 먹을 시간이에요!',
        body: '$medicineName 복약했다고 알려주세요!',
      );
    }
    log(1);
    if (!result) {
      // ignore: use_build_context_synchronously
      return showPermissionDenied(context, permission: '알람');
    }

    String? imageFilePath = _updateMedicine.imagePath;
    // 이미지가 동일하지 않을 경우에만 처리
    if (_updateMedicine.imagePath != medicienImage?.path) {
      // 2-1 기존에 저장된 이미지 삭제
      if (_updateMedicine.imagePath != null) {
        deleteImage(_updateMedicine.imagePath!);
      }

      // 2-2. save image (로컬 디렉토리 : 갤러리가 아니라 폴더에 파일로 저장)

      if (medicienImage != null) {
        imageFilePath = await saveImageToLocalDirectory(medicienImage!);
      }
    }

    // 3. update medicine (local DB, hive)
    final medicine = Medicine(
      id: updateMedicineId,
      name: medicineName,
      imagePath: imageFilePath,
      // alarms: service.alarms,
      alarms: service.alarms.toList(),
    );

    // key 값은 기존 _updateMedicine.key 값을 전달해야 한다.
    medicineRepository.updateMedicine(
        key: _updateMedicine.key, medicine: medicine);

    /*
          완료 버튼을 터치하여 등록후 페이지를 나가게 할때
          Navigator.pop(context);
          을 하면 이전 페이지로 돌아가게 된다.
          페이지가 여러개로 걸쳐 있는 경우
          Navigator.popUntil 으로 처리
          */
    // Navigator.pop(context);
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.popUntil(context, (route) => route.isFirst);
  }

  // 수정을 위해서 해당 medicine 객체를 가져오는 getter
  Medicine get _updateMedicine =>
      medicineRepository.medicineBox.values.singleWhere(
        (medicine) => medicine.id == updateMedicineId,
      );

  List<Widget> get alarmWidgets {
    final children = <Widget>[];

    /*
      children.addAll이 Iterable 형식을 받기 때문에
      Set type으로 정의한 _alarms를 map 형식으로 만들어서 넣어준다.
    */
    children.addAll(
      // map은 기존 _alarms를 건드리지 않고 새로운 열거형 자료를 생성하여 전달한다.
      // _alarms.map(
      //   (alarmTime) => AlarmBox(
      //     time: alarmTime,
      //     onPrssedMinus: () {
      //       setState(() {
      //         _alarms.remove(alarmTime);
      //       });
      //     },
      //   ),

      service.alarms.map(
        (alarmTime) => AlarmBox(time: alarmTime, service: service),
      ),
    );

    // 하단 버튼 부분 추가
    children.add(
      AddAlarmButton(service: service),
      // AddAlarmButton(
      // onPressed: () {
      //   // service 로직을 별도로 분리 처리로 주석
      //   // final now = DateTime.now();
      //   // final nowTime = DateFormat('HH:mm').format(now);
      //   setState(() {
      //     /*
      //       now.minute 값이 03분이 3으로만 가져오기 때문에
      //       날짜 형식의 포멧을 지정하기 위해서
      //       command plate에서 add depency에서 intl 로 해당 패키지를 설치.
      //     */
      //     //_alarms.add('${now.hour}:${now.minute}');
      //     _alarms.add(nowTime);
      //   });
      // },
      // ),
    );
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    super.key,
    required this.time,
    //required this.onPrssedMinus,
    required this.service,
  });

  final String time;
  //final VoidCallback onPrssedMinus;
  final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    // final initTime =
    //     DateFormat('HH:mm').parse(time); // 받은 time 값이 String 이기 때문에 형 변환

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            /* 
            마이너스 버튼 클릭시 set 열거 데이터를 삭제하고 화면을 새로고치도록 처리

            */
            //onPressed: onPrssedMinus,
            onPressed: () {
              service.removeAlarm(time);
            },
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        /*
          선택 영업을 아이콘을 제외한 전체를 하기 위해서 Expanded로 감싼다. 
        */
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.subtitle2,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TimeSettingBottomSheet(
                    // initialDateTime: initTime,
                    // service: service, initialTime: time,
                    initialTime: time,
                  );
                },
              ).then((value) {
                //Navigator.pop을 통해서 받은 결과 값
                if (value == null || value is! DateTime) return;
                service.setAlarm(
                  prevTime: time,
                  setTime: value,
                );
              });
            },
            child: Text(time),
          ),
        ),
      ],
    );
  }
}

/*
  StatelessWidget 을 상속 받지만 _setDateTime 값이 내부에서 변경될 수 있기 때문에
  ignore: must_be_immutable 처리를 해준다.
*/
// ignore: must_be_immutable
// class TimePickerBottomSheet extends StatelessWidget {
//   TimePickerBottomSheet({
//     super.key,
//     // required this.initialDateTime,
//     required this.initialTime,
//     required this.service,
//   });

//   // final DateTime initialDateTime;
//   final String initialTime;
//   final AddMedicineService service;
//   DateTime? _setDateTime; //TimePicker 에서 선택한 값을 받아올 변수

//   @override
//   Widget build(BuildContext context) {
//     final initialDateTime =
//         DateFormat('HH:mm').parse(initialTime); // 받은 time 값이 String 이기 때문에 형 변환

//     return BottomSheetBody(
//       children: [
//         /*
//           CupertinoDatePicker 를 사용할 때는 size를 지정하지 않으면 오류가 발생한다.
//           그렇게 때문에 SizedBox로 height를 설정하여 size를 지정처리한다.
//         */
//         SizedBox(
//           height: 200,
//           child: CupertinoDatePicker(
//             onDateTimeChanged: (dateTime) {
//               _setDateTime = dateTime;
//             },
//             mode: CupertinoDatePickerMode.time, // 시간만 선택하게 설정
//             initialDateTime: initialDateTime, // 초기 값을 설정하기 위한 속성
//           ),
//         ),
//         const SizedBox(
//           height: reqularSpace,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: SizedBox(
//                 height: submitButtonHeight,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     textStyle: Theme.of(context).textTheme.subtitle1,
//                     backgroundColor: Colors.white,
//                     foregroundColor: JavadoriColors.primaryColor,
//                     // primary: Colors.white,
//                     // onPrimary: Colors.black,
//                   ),
//                   child: const Text('취소'),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: smallSpace,
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: submitButtonHeight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     service.setAlarm(
//                       prevTime: initialTime,
//                       setTime: _setDateTime ?? initialDateTime,
//                     );
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     textStyle: Theme.of(context).textTheme.subtitle1,
//                   ),
//                   child: const Text('선택'),
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    super.key,
    //required this.onPressed,
    required this.service,
  });

  // service 객체로 대체 처리
  // final VoidCallback onPressed;

  final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
      //onPressed: () {},
      // onPressed: onPressed,
      onPressed: service.addNowAlarm,
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(CupertinoIcons.plus_circle_fill),
          ),

          /*
            선택 영업을 아이콘을 제외한 전체를 하기 위해서 Expanded로 감싼다. 
          */
          Expanded(
            flex: 5,
            child: Center(child: Text('복용 시간 추가')),
          ),
        ],
      ),
    );
  }
}
