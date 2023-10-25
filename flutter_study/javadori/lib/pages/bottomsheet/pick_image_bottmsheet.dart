import 'package:flutter/material.dart';

import '../../components/javadori_widgets.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {super.key,
      required this.onPressedCamera,
      required this.onPressedGallery});

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          // onPressed: () {
          //   ImagePicker()
          //       .pickImage(source: ImageSource.camera)
          //       .then((xfile) {
          //     if (xfile != null) {
          //       setState(() {
          //         _pcikedImage = File(xfile.path);
          //       });
          //     }
          //     // 카메라를 촬영 후 해당 팝업을 닫게 처리
          //     Navigator.maybePop(context);
          //   });
          // },
          onPressed: onPressedCamera,
          child: const Text('카메라로 촬영'),
        ),
        TextButton(
          // onPressed: () {
          //   ImagePicker()
          //       .pickImage(source: ImageSource.gallery)
          //       .then((xfile) {
          //     if (xfile != null) {
          //       //return; //xfile이 null 일경우 pass 처리
          //       setState(() {
          //         _pcikedImage = File(xfile.path);
          //       });
          //     }
          //     // 이미지를 선택 후 해당 팝업을 닫게 처리
          //     Navigator.maybePop(context);
          //   });
          // },
          onPressed: onPressedGallery,
          child: const Text('앨범에서 가져오기'),
        ),
      ],
    );
  }
}
