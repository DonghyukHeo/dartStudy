import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:javadori/components/javadori_constants.dart';
import 'package:javadori/components/javadori_page_route.dart';
import 'package:javadori/main.dart';
import 'package:javadori/models/medicine_alarm.dart';
import 'package:javadori/models/medicine_history.dart';
import 'package:javadori/pages/bottomsheet/more_action_bottmsheet.dart';
import 'package:javadori/pages/bottomsheet/time_setting_bottomsheet.dart';
import 'package:javadori/pages/today/image_detail_page.dart';

import '../add_medicine/add_medicine_page.dart';

/*
  2023.09.26

  약 복용전 Tile 리스트를 개별 class로 분리 처리
  복용전과 복용후에 대해서 각각 처리를 위해서 분리
*/

class BeforeTakeTile extends StatelessWidget {
  const BeforeTakeTile({
    super.key,
    required this.medicineAlarm,
    // required this.name,
  });

  // final String name;
  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    //context 가 필요 하기 때문에 build 위젯 안쪽에 선언
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
      // color: Colors.yellow,
      child: Row(
        children: [
          // MedicineImageButton(medicineAlarm: medicineAlarm),
          MedicineImageButton(imagePath: medicineAlarm.imagePath),
          const SizedBox(
            width: smallSpace,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTileBody(textStyle, context),
            ),
          ),
          _MoreButton(medicineAlarm: medicineAlarm),
        ],
      ),
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
      Text(
        // '🕑 08:30',
        '🕑 ${medicineAlarm.alarmsTime}',
        // style: Theme.of(context).textTheme.bodyText2,
        style: textStyle,
      ),
      const SizedBox(
        height: 6,
      ),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center, // wrap의 중앙정렬
        children: [
          // Text('$name,', style: textStyle),
          Text('${medicineAlarm.name},', style: textStyle),
          TitleActionButton(
            onTap: () {
              historyRepository.addHistory(
                MedicineHistory(
                  medicineId: medicineAlarm.id,
                  alarmTime: medicineAlarm.alarmsTime,
                  takeTime: DateTime.now(),
                  medicineKey: medicineAlarm.key,
                  name: medicineAlarm.name,
                  imagePath: medicineAlarm.imagePath,
                ),
              );
            },
            title: '지금',
          ),
          Text('|', style: textStyle),
          TitleActionButton(
            onTap: () => _onPreviousTake(context),
            title: '아까',
          ),
          Text('먹었어요!', style: textStyle),
        ],
      )
    ];
  }

  /*
    StatelessWidget 이기 때문에 context를 받아와야 한다.
    statefulWidget은 context를 매개변수로 받지 않아도 된다.
  */
  void _onPreviousTake(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          TimeSettingBottomSheet(initialTime: medicineAlarm.alarmsTime),
    ).then((takeDateTime) {
      // print(takeDateTime);

      if (takeDateTime == null || takeDateTime is! DateTime) {
        return;
      }
      historyRepository.addHistory(
        MedicineHistory(
          medicineId: medicineAlarm.id,
          alarmTime: medicineAlarm.alarmsTime,
          takeTime: takeDateTime,
          medicineKey: medicineAlarm.key,
          name: medicineAlarm.name,
          imagePath: medicineAlarm.imagePath,
        ),
      );
    });
  }
}

class AfterTakeTile extends StatelessWidget {
  const AfterTakeTile({
    super.key,
    required this.medicineAlarm,
    required this.history,
    // required this.name,
  });

  // final String name;
  final MedicineAlarm medicineAlarm;
  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    //context 가 필요 하기 때문에 build 위젯 안쪽에 선언
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
      // color: Colors.yellow,
      child: Row(
        children: [
          Stack(
            children: [
              // MedicineImageButton(medicineAlarm: medicineAlarm),
              MedicineImageButton(imagePath: medicineAlarm.imagePath),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green.withOpacity(0.7),
                child: const Icon(
                  CupertinoIcons.check_mark,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: smallSpace,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTileBody(textStyle, context),
            ),
          ),
          _MoreButton(medicineAlarm: medicineAlarm),
        ],
      ),
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
      Text.rich(
        TextSpan(
          text: '✅ ${medicineAlarm.alarmsTime} → ',
          style: textStyle,
          children: [
            TextSpan(
              //text: '20:19',
              text: takeTimeStr,
              style: textStyle?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 6,
      ),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center, // wrap의 중앙정렬
        children: [
          // Text('$name,', style: textStyle),
          Text('${medicineAlarm.name},', style: textStyle),
          TitleActionButton(
            onTap: () => _onTap(context),
            title:
                DateFormat('HH시 mm분에').format(history.takeTime), //'20시 19분에',
          ),
          Text('먹었어요!', style: textStyle),
        ],
      )
    ];
  }

  // 시간 정보를 String 형식으로 반환하는 getter
  String get takeTimeStr => DateFormat('HH:mm').format(history.takeTime);

  // 등록한 시간을 변경하기 위한 부분 처리
  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TimeSettingBottomSheet(
        initialTime: takeTimeStr,
        submitTitle: '수정',
        bottomWidget: TextButton(
            onPressed: () {
              historyRepository.deletHistory(history.key);
              Navigator.pop(context);
            },
            child: Text(
              '복약 시간을 지우고 싶어요.',
              style: Theme.of(context).textTheme.bodyText2,
            )),
      ),
    ).then((takeDateTime) {
      // print(takeDateTime);

      if (takeDateTime == null || takeDateTime is! DateTime) {
        return;
      }

      historyRepository.updateHistory(
        key: history.key,
        history: MedicineHistory(
          medicineId: medicineAlarm.id,
          alarmTime: medicineAlarm.alarmsTime,
          takeTime: takeDateTime,
          medicineKey: medicineAlarm.key,
          name: medicineAlarm.name,
          imagePath: medicineAlarm.imagePath,
        ),
      );
    });
  }
}

class TitleActionButton extends StatelessWidget {
  const TitleActionButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.w500);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}

/*
  2023.10.12
  약 정보 및 history 내용 삭제 처리 구현
  약 정보만 삭제, 약과 history 동시 삭제 부분 처리
  notification service 에 구현한 메서드를 호출 적용 처리
*/
class _MoreButton extends StatelessWidget {
  const _MoreButton({
    super.key,
    required this.medicineAlarm,
  });

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // medicineRepository.deleteMedicine(medicineAlarm.key);
        showModalBottomSheet(
            context: context,
            builder: (context) => MoreActionBottomSheet(
                  onPressedModify: () {
                    Navigator.push(
                      context,
                      FadePageRoute(
                          page: AddMedicienPage(
                        updateMedicineId: medicineAlarm.id,
                      )),
                    ).then((_) => Navigator.maybePop(
                        context)); // 페이지를 혹시나 닫을 것이 있으면 pop 처리
                  },
                  onPressedDeleteOnlyMedicine: () {
                    // 알람삭제 (id 값을 확인하기 위해서 알람을 먼저 삭제한다.)
                    notification.deleteMultipleAlarm(alarmIds);
                    // hive 데이터 삭제
                    medicineRepository.deleteMedicine(medicineAlarm.key);
                    // pop
                    Navigator.pop(context);
                  },
                  onPressedDeleteAll: () {
                    // 알람삭제 (id 값을 확인하기 위해서 알람을 먼저 삭제한다.)
                    notification.deleteMultipleAlarm(alarmIds);
                    // hive history 데이터 삭제
                    historyRepository.deletAllHistory(keys);
                    // hive 데이터 삭제
                    medicineRepository.deleteMedicine(medicineAlarm.key);
                    // pop
                    Navigator.pop(context);
                  },
                ));
      },
      child: const Icon(CupertinoIcons.ellipsis_vertical),
    );
  }

  /*
    medicineAlarm 값은 단일값이므로 해당 단일 값에서 
    분할하기 전의 전체 값을 도출하도록 getter를 만든다.
  */
  List<String> get alarmIds {
    final medicine = medicineRepository.medicineBox.values
        .singleWhere((element) => element.id == medicineAlarm.id);

    final alarmIds = medicine.alarms
        .map((alarmStr) => notification.alarmId(medicineAlarm.id, alarmStr))
        .toList();

    return alarmIds;
  }

  // history key 값 반환
  Iterable<int> get keys {
    final histoies = historyRepository.historyBox.values.where((history) =>
        history.medicineId == medicineAlarm.id &&
        history.medicineKey == medicineAlarm.key);

    final keys = histoies.map((e) => e.key as int);

    return keys;
  }
}

class MedicineImageButton extends StatelessWidget {
  const MedicineImageButton({
    super.key,
    this.imagePath,
    // required this.medicineAlarm,
  });

  // final MedicineAlarm medicineAlarm;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding:
          EdgeInsets.zero, // CupertinoButton은 자체적으로 padding 이 기본값이 있어서 0로 제거
      // onPressed: medicineAlarm.imagePath == null // image path가 없을 때는 클릭이 안되게
      onPressed: imagePath == null // image path가 없을 때는 클릭이 안되게
          ? null
          : () {
              Navigator.push(
                context,
                FadePageRoute(
                  // page: ImageDetailPage(medicineAlarm: medicineAlarm),
                  page: ImageDetailPage(imagePath: imagePath!),
                ),
              );
            },
      child: CircleAvatar(
        radius: 40,
        /*
          2023.09.20

          ios 14 버젼 이후에서는 디버그 모드에서 단독적으로 동작을 못하므로
          (실행 주기에 맞추어 동작하고 사라진다.) 에러가 발생한다.
          앱을 배포하거나 릴리즈 버젼으로 동작시에만 정상적으로 동작이 된다.
          즉, 바로 실행시에는 동작이 되지만 앱을 종료후에 재실행시에 경로가 달라지기 때문에
          발생하는 에러이다.
        */
        // foregroundImage: medicineAlarm.imagePath == null
        foregroundImage: imagePath == null
            ? null
            // : FileImage(File(medicineAlarm.imagePath!)),
            : FileImage(File(imagePath!)),
        // imagePath가 null 이면 아이콘으로 대체 처리
        child: imagePath == null ? const Icon(CupertinoIcons.alarm_fill) : null,
      ),
    );
  }
}
