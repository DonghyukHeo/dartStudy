import 'package:flutter/material.dart';

import '../../components/javadori_widgets.dart';

/*
  2023.10.10
  더보기 바텀시트 부분 구현을 위한 UI 구현
  약 정보 수정, 약 정보 삭제, 약 기록 및 약 정보 삭제 버튼 UI 만들기
*/

class MoreActionBottomSheet extends StatelessWidget {
  const MoreActionBottomSheet({
    super.key,
    required this.onPressedModify,
    required this.onPressedDeleteOnlyMedicine,
    required this.onPressedDeleteAll,
  });

  final VoidCallback onPressedModify;
  final VoidCallback onPressedDeleteOnlyMedicine;
  final VoidCallback onPressedDeleteAll;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedModify,
          child: const Text('약 정보 수정'),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          onPressed: onPressedDeleteOnlyMedicine,
          child: const Text('약 정보 삭제'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.red),
          onPressed: onPressedDeleteAll,
          child: const Text('약 기록과 함께 약 정보 삭제'),
        ),
      ],
    );
  }
}
