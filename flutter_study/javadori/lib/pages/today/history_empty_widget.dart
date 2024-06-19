import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javadori/components/javadori_constants.dart';

/*
  2023.10.18

  History 페이지에서 데이터가 없는 상태에서 빈 화면을 보여주기 위한 화면 구성
*/

class HistoryEmptyWidget extends StatelessWidget {
  const HistoryEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Center(child: Text('복용한 기록이 없습니다.')),
          const SizedBox(height: smallSpace),
          Text(
            '약 복용 후 복용했다고 알려주세요!',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: largeSpace),
          const Align(
            alignment: Alignment(-0.6, 0),
            child: Icon(CupertinoIcons.arrow_down),
          ),
          const SizedBox(height: reqularSpace),
        ],
      ),
    );
  }
}
