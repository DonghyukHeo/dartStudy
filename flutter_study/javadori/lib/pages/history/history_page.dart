import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:javadori/pages/today/history_empty_widget.dart';
// import 'package:javadori/pages/add_medicine/add_medicine_page.dart';
import 'package:javadori/pages/today/today_take_tile.dart';
import '../../components/javadori_constants.dart';
import '../../main.dart';
import '../../models/medicine.dart';
import '../../models/medicine_history.dart';

/*
  2023.10.05
  복약 히스토리 페이지 구현
  복약 등록한 정보를 목록 형태로 나열하여 보여주는 페이지

*/
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '잘 복용했어요👏🏻',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: reqularSpace,
        ),
        const Divider(
          height: 1,
          thickness: 1.0,
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: historyRepository.historyBox.listenable(),
            builder: _buildListView,
          ),
        ),
      ],
    );
  }

  Widget _buildListView(context, Box<MedicineHistory> historyBox, _) {
    final histories =
        historyBox.values.toList().reversed.toList(); // reversed로 역순 정렬 처리
    // final histories = [];

    if (histories.isEmpty) {
      return const HistoryEmptyWidget();
    } else {
      return ListView.builder(
          itemCount: histories.length,
          itemBuilder: (context, index) {
            final history = histories[index];
            return _TimeTile(history: history);
          });
    }
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    super.key,
    required this.history,
  });

  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    // print(history);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            //2023\n10.05.금 \n은 줄바꿈
            // local 정보를 사용하기 위해서는 main.dart에 initializeDateFormatting 처리를 해주어야 한다.
            DateFormat('yyyy\nMM.dd E', 'ko_KR').format(history.takeTime),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  height: 1.6,
                  leadingDistribution:
                      TextLeadingDistribution.even, // 높이에 대한 가운데 정렬 처리
                ),
          ),
        ),
        const SizedBox(
          width: smallSpace,
        ),
        const Stack(
          alignment: Alignment(0.0, -0.3),
          children: [
            SizedBox(
              height: 130,
              child: VerticalDivider(
                //세로로 구분처리
                width: 1,
                thickness: 1,
              ),
            ),
            CircleAvatar(
              radius: 4,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*
              Visibility는 visible 의 조건이 참일 경우 처리가 되도록 하는 위젯
              */
              // if(medicine.imagePath != null)
              Visibility(
                visible: medicine.imagePath != null,
                child: MedicineImageButton(imagePath: medicine.imagePath),
              ),
              const SizedBox(width: smallSpace),
              Text(
                // local 정보를 사용하기 위해서는 main.dart에 initializeDateFormatting 처리를 해주어야 한다.
                DateFormat('a hh:mm', 'ko_KR').format(history.takeTime) +
                    '\n' +
                    medicine.name,
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      height: 1.6,
                      leadingDistribution:
                          TextLeadingDistribution.even, // 높이에 대한 가운데 정렬 처리
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Medicine get medicine {
    /*
      2023.10.06
      history를 생성자를 통해서 받기 때문에 medicineId와 같을 경우 Medicine 객체를 반환 처리
      복약정보를 삭제 했을 경우에는 Medicine 객체를 넘기지 못하기 때문에
      orElse 로 Medicine 객체를 아무것도 없는 정보로 넘기도록 처리
    */
    return medicineRepository.medicineBox.values.singleWhere(
      (element) =>
          element.id == history.medicineId &&
          element.key == history.medicineKey,
      orElse: () => Medicine(
        id: -1,
        imagePath: history.imagePath,
        alarms: [],
        name: history.name, //'삭제된 약입니다.',
      ),
    );
  }
}
