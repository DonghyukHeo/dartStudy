import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'javadori_constants.dart';

/*
  하단 BottomSheet 부분을 공통적으로 사용할 요소를 별도의 위젯으로 분리 처리
  
*/
class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min, //크기를 작게
          children: children,
        ),
      ),
    );
  }
}

// BuildContext 를 받도록 처리
void showPermissionDenied(
  BuildContext context, {
  required String permission,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        //duration: Duration(),
        content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$permission 권한이 없습니다.'),
        const TextButton(
          // onPressed: () {
          //   openAppSettings(); //설정창으로 이동
          // },
          onPressed: openAppSettings,
          child: Text('설정창으로 이동'),
        )
      ],
    )),
  );
}
