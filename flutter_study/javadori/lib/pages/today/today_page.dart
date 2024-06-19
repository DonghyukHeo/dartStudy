// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:javadori/components/javadori_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:javadori/components/javadori_page_route.dart';
import 'package:javadori/main.dart';
import 'package:javadori/models/medicine_alarm.dart';
import 'package:javadori/models/medicine_history.dart';
// import 'package:javadori/pages/bottomsheet/time_setting_bottomsheet.dart';
import 'package:javadori/pages/today/today_empty_widget.dart';
import 'package:javadori/pages/today/today_take_tile.dart';
import '../../models/medicine.dart';
// import '../../models/medicine_history.dart';

/*
  2023.09.19
  
  목록 창 구현

  ListView에 ListTile로 구현시 디자이너가 없을 경우 style 상관없이 사용이 편하나
  커스텀 하기에는 처리해야 될 요소가 많다.
*/
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  // final list = [
  //   '약3',
  //   '약이름2',
  //   '약이름 테스트1',
  //   '약이름 텍스트 하하하연결문자작성시1',
  //   '약이름 테스트',
  //   '약이름 텍스트 하하하연결문자작성시2',
  //   '약이름 테스트',
  //   '약이름 텍스트 하하하연결문자작성시3',
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오를 복용할 약은?',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: reqularSpace),
        // const Divider(height: 1, thickness: 2.0),
        Expanded(
          // child: ListView(
          //   children: const [
          //     MedicineListTile(name: '약이름'),
          //     MedicineListTile(name: '약이름'),
          //     MedicineListTile(name: '약이름 테스트'),
          //     MedicineListTile(name: '약이름 테스트 약이름 약이름 하하하'),
          //     MedicineListTile(name: '약이름'),
          //   ],
          // ),
          // child: ListView.builder(
          //   itemCount: list.length,
          //   itemBuilder: (context, index) {
          //     return MedicineListTile(
          //       name: list[index],
          //     );
          //   },
          // ),

          /*
            아이템 리스트에서 각 사이사이 여백을 주기 위해서
            ListView.builder 대신 separated 로 변경처리
          */
          child: ValueListenableBuilder(
            valueListenable: medicineRepository.medicineBox.listenable(),
            builder: _builderMedicineListView,
          ),
        ),
      ],
    );
  }

  // 개별 위젯으로 분리 처리
  Widget _builderMedicineListView(context, Box<Medicine> box, _) {
    final medicines = box.values.toList();
    final medicineAlarms = <MedicineAlarm>[];

    /*
      데이터가 없는 상태인지 체크
    */
    if (medicines.isEmpty) {
      return const TodayEmptyWidget();
    }

    for (var medicine in medicines) {
      for (var alarm in medicine.alarms) {
        medicineAlarms.add(MedicineAlarm(
          id: medicine.id,
          name: medicine.name,
          imagePath: medicine.imagePath,
          alarmsTime: alarm,
          key: medicine.key,
        ));
      }
    }

    // 정렬 처리
    medicineAlarms.sort(
      (a, b) => DateFormat('HH:mm')
          .parse(a.alarmsTime)
          .compareTo(DateFormat('HH:mm').parse(b.alarmsTime)),
    );

    return Column(
      children: [
        const Divider(height: 1, thickness: 1.0),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: smallSpace),
            // itemCount: medicines.length,
            itemCount: medicineAlarms.length,
            itemBuilder: (context, index) {
              return _buildListTile(medicineAlarms[index]);
            },
            // 리스트 사이에 구분정보를 어떤 형식으로 구분할지 정의
            separatorBuilder: (context, index) {
              // return const SizedBox(height: reqularSpace);
              return const Divider(
                  height: reqularSpace); // divider로 구분선을 넣어서 구분이 잘되게 처리
            },
          ),
        ),
      ],
    );
  }

  /*
    2023.09.27

    히스토리 복용에 대한 구분을 별도 위젯으로 분리 
    
    리스트 타일에서 복용해야 될 것과 복용한 것에 대해서 구분하여 처리하기 위해서
    개별 위젯으로 분리하여 약의 id 및 날짜 정보를 체크하여 
    복용전과 복용후 처리에 대한 처리를 하게 한다.
  */
  Widget _buildListTile(MedicineAlarm medicineAlarm) {
    return ValueListenableBuilder(
        valueListenable: historyRepository.historyBox.listenable(),
        builder: (context, Box<MedicineHistory> historyBox, _) {
          if (historyBox.values.isEmpty) {
            return BeforeTakeTile(
              // name: medicines[index].name,
              // name: medicineAlarms[index].name,
              medicineAlarm: medicineAlarm,
            );
          }

          // historyRepository.deletHistory(-1); //key 삭제

          /*
            historyBox의 값이 Iterable 타입의 값이므로 그 중 동일한 값일 경우를 
            찾아야 하기 때문에 singleWhere을 사용하여 검색
          */
          final todayTakeHistory = historyBox.values.singleWhere(
            (history) =>
                history.medicineId == medicineAlarm.id &&
                history.medicineKey == medicineAlarm.key &&
                history.alarmTime == medicineAlarm.alarmsTime &&
                //history.takeTime.difference(DateTime.now()).inDays == 0,
                isToday(history.takeTime, DateTime.now()),
            orElse: () => MedicineHistory(
              medicineId: -1,
              alarmTime: '',
              takeTime: DateTime.now(),
              medicineKey: -1,
              name: '',
              imagePath: null,
            ),
          );
          //print(todayTakeHistory);

          if (todayTakeHistory.medicineId == -1 &&
              todayTakeHistory.alarmTime == '') {
            return BeforeTakeTile(
              // name: medicines[index].name,
              // name: medicineAlarms[index].name,
              medicineAlarm: medicineAlarm,
            );
          } else {
            return AfterTakeTile(
              // name: medicines[index].name,
              // name: medicineAlarms[index].name,
              medicineAlarm: medicineAlarm,
              history: todayTakeHistory,
            );
          }
        });
  }
}

// 동일한 날짜인지 체크
bool isToday(DateTime source, DateTime destination) {
  return source.year == destination.year &&
      source.month == destination.month &&
      source.day == destination.day;
}

/*
  반복 되는 부분을 개별 위젯으로 분리
*/
// class BeforeTakeTile extends StatelessWidget {
//   const BeforeTakeTile({
//     super.key,
//     required this.medicineAlarm,
//     // required this.name,
//   });

//   // final String name;
//   final MedicineAlarm medicineAlarm;

//   @override
//   Widget build(BuildContext context) {
//     //context 가 필요 하기 때문에 build 위젯 안쪽에 선언
//     final textStyle = Theme.of(context).textTheme.bodyText2;

//     return Container(
//       // color: Colors.yellow,
//       child: Row(
//         children: [
//           CupertinoButton(
//             padding: EdgeInsets
//                 .zero, // CupertinoButton은 자체적으로 padding 이 기본값이 있어서 0로 제거
//             onPressed:
//                 medicineAlarm.imagePath == null // image path가 없을 때는 클릭이 안되게
//                     ? null
//                     : () {
//                         Navigator.push(
//                           context,
//                           FadePageRoute(
//                             page: ImageDetailPage(medicineAlarm: medicineAlarm),
//                           ),
//                         );
//                       },
//             child: CircleAvatar(
//               radius: 40,
//               /*
//                 2023.09.20

//                 ios 14 버젼 이후에서는 디버그 모드에서 단독적으로 동작을 못하므로
//                 (실행 주기에 맞추어 동작하고 사라진다.) 에러가 발생한다.
//                 앱을 배포하거나 릴리즈 버젼으로 동작시에만 정상적으로 동작이 된다.
//                 즉, 바로 실행시에는 동작이 되지만 앱을 종료후에 재실행시에 경로가 달라지기 때문에
//                 발생하는 에러이다.
//               */
//               foregroundImage: medicineAlarm.imagePath == null
//                   ? null
//                   : FileImage(File(medicineAlarm.imagePath!)),
//             ),
//           ),
//           const SizedBox(
//             width: smallSpace,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   // '🕑 08:30',
//                   '🕑 ${medicineAlarm.alarmsTime}',
//                   // style: Theme.of(context).textTheme.bodyText2,
//                   style: textStyle,
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.center, // wrap의 중앙정렬
//                   children: [
//                     // Text('$name,', style: textStyle),
//                     Text('${medicineAlarm.name},', style: textStyle),
//                     TitleActionButton(
//                       onTap: () {},
//                       title: '지금',
//                     ),
//                     Text('|', style: textStyle),
//                     TitleActionButton(
//                       onTap: () {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) => TimeSettingBottomSheet(
//                               initialTime: medicineAlarm.alarmsTime),
//                         ).then((takeDateTime) {
//                           // print(takeDateTime);

//                           if (takeDateTime == null ||
//                               takeDateTime is! DateTime) {
//                             return;
//                           }
//                           historyRepository.addHistory(
//                             MedicineHistory(
//                                 medicineId: medicineAlarm.id,
//                                 alarmTime: medicineAlarm.alarmsTime,
//                                 takeTime: takeDateTime),
//                           );
//                         });
//                       },
//                       title: '아까',
//                     ),
//                     Text('먹었어요!', style: textStyle),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           CupertinoButton(
//             onPressed: () {
//               medicineRepository.deleteMedicine(medicineAlarm.key);
//             },
//             child: const Icon(CupertinoIcons.ellipsis_vertical),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImageDetailPage extends StatelessWidget {
//   const ImageDetailPage({
//     super.key,
//     required this.medicineAlarm,
//   });

//   final MedicineAlarm medicineAlarm;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const CloseButton(),
//       ),
//       body: Center(
//         child: Image.file(
//           File(medicineAlarm.imagePath!),
//         ),
//       ),
//     );
//   }
// }

// class TitleActionButton extends StatelessWidget {
//   const TitleActionButton({
//     super.key,
//     required this.onTap,
//     required this.title,
//   });

//   final VoidCallback onTap;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     final buttonTextStyle = Theme.of(context)
//         .textTheme
//         .bodyText2
//         ?.copyWith(fontWeight: FontWeight.w500);

//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           title,
//           style: buttonTextStyle,
//         ),
//       ),
//     );
//   }
// }
