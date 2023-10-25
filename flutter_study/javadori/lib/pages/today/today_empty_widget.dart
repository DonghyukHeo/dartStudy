import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javadori/components/javadori_constants.dart';

/*
  2023.09.21

  데이터가 없는 상태에서 빈 화면을 보여주기 위한 화면 구성
  데이터 추가 요청 안내 처리
*/

class TodayEmptyWidget extends StatelessWidget {
  const TodayEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Center(child: Text('추가된 약이 없습니다.')),
          const SizedBox(
            height: smallSpace,
          ),
          Text(
            '약을 추가해주세요!',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const Icon(CupertinoIcons.arrow_down),
          const SizedBox(
            height: largeSpace,
          ),
        ],
      ),
    );
  }
}
