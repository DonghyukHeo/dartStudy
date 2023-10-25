import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javadori/components/javadori_constants.dart';
import 'package:javadori/components/javadori_page_route.dart';
import 'package:javadori/components/javadori_widgets.dart';
import 'package:javadori/main.dart';
import 'package:javadori/pages/add_medicine/add_alarm_page.dart';
import 'package:javadori/pages/add_medicine/components/add_page_widget.dart';

import '../../models/medicine.dart';
import '../bottomsheet/pick_image_bottmsheet.dart';

/*
  2023.09.01

  데이터 추가를 위한 화면 UI 만들기

  아이폰 x 이상의 경우 하단에 컨트롤 바가 있기 때문에 SafeArea 로 감싸면
  노츠나 하단바를 제외한 컨버스 안에서 그리도록 한다. 
  현재로써는 아이폰 X 이후 버전에서만 영향이 간다.

  2023.10.13
  데이터 추가 창에 데이터 수정을 위한 루핀을 추가 적용 구현
  UI가 동일하기 때문에 수정을 위한 정보를 불러와서 수정이 가능하도록 한다.
*/

class AddMedicienPage extends StatefulWidget {
  const AddMedicienPage({super.key, this.updateMedicineId = -1});

  final int updateMedicineId; //수정시 필요한 id 값

  @override
  State<AddMedicienPage> createState() => _AddMedicienPageState();
}

class _AddMedicienPageState extends State<AddMedicienPage> {
  // final _nameController = TextEditingController(); //약이름 입력 항목 controller
  late TextEditingController _nameController; //약이름 입력 항목 controller
  File? _medicienImage;

  bool get _isUpdate => widget.updateMedicineId != -1;
  // 수정을 위해서 해당 medicine 객체를 가져오는 getter
  Medicine get _updateMedicine =>
      medicineRepository.medicineBox.values.singleWhere(
        (medicine) => medicine.id == widget.updateMedicineId,
      );

  // 수정화면일 경우 약 이름 및 사진을 불러와야 하기 때문에 초기화시 수정화면인지 체크하여 처리한다.
  @override
  void initState() {
    super.initState();

    if (_isUpdate) {
      _nameController = TextEditingController(text: _updateMedicine.name);
      if (_updateMedicine.imagePath != null) {
        _medicienImage = File(_updateMedicine.imagePath!);
      }
    } else {
      _nameController = TextEditingController();
    }
  }

  // controller는 앱이 닫힐때 dispose 하도록 처리
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(), //닫기 버튼
      ),
      /* 
        TextFormField 를 통해서 키보드가 활성화 되었을 때 입력 폼 외에 터치시 
        키보드를 감출려면 GestureDetector 로 감싸고 onTap에서 
        FocusScope.of(context).unfocus()를 해서 focus가 비활성화 하여 키보드를 닫게 한다.
      */
      body: SingleChildScrollView(
        child: AddPageBody(
          children: [
            // const SizedBox(
            //   height: largeSpace, // javadori_constants에 사용자 정의한 높이 수치를 적용
            // ),
            Text(
              '어떤 약이에요?',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: largeSpace),
            Center(
              child: _MedicineImageButton(
                updateImage: _medicienImage,
                changeImageFile: (File? value) {
                  _medicienImage = value;
                },
              ),
            ),
            const SizedBox(height: largeSpace + reqularSpace),
            Text(
              '약이름',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(
              controller: _nameController,
              maxLength: 20, // 입력 최대 값 설정 (하단 길이값이 표시됨)
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done, // submit 버튼 형식 지정
              style: Theme.of(context).textTheme.bodyText1,
              // 입력 항목에 대한 hint 정보 표시
              decoration: InputDecoration(
                hintText: '복용할 약 이름을 기입해주세요.',
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding:
                    textFieldContentPadding, //const EdgeInsets.symmetric(horizontal: 6),
              ),
              onChanged: (str) {
                setState(() {}); //입력시 화면이 변경이 되도록 호출
              },
            ),
          ],
        ),
      ),

      /* 
      아이폰 x 이상의 경우 하단에 컨트롤 바가 있기 때문에 SafeArea 로 감싸면
      노츠나 하단바를 제외한 컨버스 안에서 그리도록 한다. 
      현재로써는 아이폰 X 이후 버전에서만 영향이 간다.

      bottomNavigationBar 에 자체적으로 Text Style이 있기 때문에
      Text 에 별도의 style을 주는 것이 아니다 bottomNavigationBar 의 textStyle을 지정해야 한다.
      */
      bottomNavigationBar: BottomSubmitButton(
        onPressed: _nameController.text.isEmpty
            ? null // null 값으로 하면 해당 버튼이 disabled가 된다.
            : _onAlarmPage,
        text: '다음',
      ),
    );
  }

  /* 
    알람 페이지로 이동 처리 

    이미지 파일정보는 별도의 위젯으로 분리하였기 때문에 해당 위젯에서
    ValueChanged 로 전달 받을 데이터 객체를 설정한 후 
    widget.valuechanged 로 설정한 객체에 값을 전달하여 받아야 한다.
  */
  void _onAlarmPage() {
    Navigator.push(
      context,
      // MaterialPageRoute 대신 Fade 효과로 페이지 전환하도록 처리
      FadePageRoute(
        page: AddAlarmPage(
          medicienImage: _medicienImage,
          medicineName: _nameController.text,
          updateMedicineId: widget.updateMedicineId,
        ),
      ),
      // MaterialPageRoute(
      //   builder: (context) => AddAlarmPage(
      //     medicienImage: _medicienImage,
      //     medicineName: _nameController.text,
      //   ),
      // ),
    );
  }
}

/*
  동일한 코드를 사용하는 부분을 별도의 위젯으로 분리하여 
  재사용 가능하게 처리한다.
*/
// class AddPageBody extends StatelessWidget {
//   const AddPageBody({super.key, required this.children});

//   final List<Widget> children;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context)
//             .unfocus(); //입력창에서 키보드를 불러온 이후 다른 곳에 터치시 키보드를 닫게 처리
//       },
//       // 키보드 호출시 화면이 overflow 되지 않게 스크롤이 가능하도록 SingleChildScrollView로 감싼다.
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: pagePadding, //const EdgeInsets.all(20.0),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start, children: children),
//         ),
//       ),
//     );
//   }
// }

/*
  복잡한 부분을 개별 위젯으로 분리 처리
*/
class _MedicineImageButton extends StatefulWidget {
  const _MedicineImageButton({
    super.key,
    required this.changeImageFile,
    this.updateImage,
  });

  /*
    해당 위젯의 외부에 전달 하기 위한 처리
    widget.changeImageFile(_pcikedImage) 로 값을 설정
  */
  final ValueChanged<File?> changeImageFile;
  final File? updateImage;

  @override
  State<_MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<_MedicineImageButton> {
  File? _pcikedImage;
  // 카메라에서 가져올 이미지

  // 수정시 이미지 정보를 가져와서 처리하기 위해서 처음 initState로 처리한다.
  @override
  void initState() {
    super.initState();

    _pcikedImage = widget.updateImage;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _pcikedImage == null
            ? null
            : EdgeInsets
                .zero, // 기본적으로 16의 padding 값이 있기 때문에 전체표시가 안되므로 zero로 해야 전체 표시가 된다.
        /*
          2023.09.05
          카메라 및 갤러리에서 사진 불러오기
          
          버튼 클릭시 카메라 및 갤러리 접근 위해서 ctrl+shift+p => add dependency => image_picker 추가
          pubspec.yaml 에서 image_picker 추가 확인
          ios의 info.plist에 권한 관련 부분 추가 설정 할 것
        */
        onPressed: _showBottomSheet,
        child: _pcikedImage == null
            ? const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30,
                color: Colors.white,
              )
            : CircleAvatar(
                foregroundImage: FileImage(_pcikedImage!),
                radius: 40,
              ),
      ),
    );
  }

  /*
    BottomSheet 부분 개별 분리
  */
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
            onPressedCamera: () {
              _onPressed(ImageSource.camera);
            },
            onPressedGallery: () => _onPressed(ImageSource.gallery),
          );
        });

    // ImagePicker()
    //     .pickImage(source: ImageSource.camera)
    //     .then((xfile) {
    //   if (xfile == null) return; //xfile이 null 일경우 pass 처리
    //   setState(() {
    //     _pcikedImage = File(xfile.path);
    //   });
    // });
  }

  /*
    BottomSheet에서 onPressed 부분을 내부 함수로 분리 
  */
  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile != null) {
        setState(() {
          _pcikedImage = File(xfile.path);
          widget.changeImageFile(_pcikedImage); // 위젯 외부에 전달하기 위한 처리
        });
      }
      // 카메라를 촬영 후 해당 팝업을 닫게 처리
      Navigator.maybePop(context);
      // });
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      // 설정창으로 이동 처리
      showPermissionDenied(context, permission: '카메라 및 갤러리 접근');
    }); // error 발생시 처리
  }
}

/*
  2023.09.06
  위젯 및 서비스 코드 정리

  이미지를 선택하여 표시되는 부분을 별도의 위젯으로 분리하여 
  코드를 가독성을 높인다.
*/
// class PickImageBottomSheet extends StatelessWidget {
//   const PickImageBottomSheet(
//       {super.key,
//       required this.onPressedCamera,
//       required this.onPressedGallery});

//   final VoidCallback onPressedCamera;
//   final VoidCallback onPressedGallery;

//   @override
//   Widget build(BuildContext context) {
//     return BottomSheetBody(
//       children: [
//         TextButton(
//           // onPressed: () {
//           //   ImagePicker()
//           //       .pickImage(source: ImageSource.camera)
//           //       .then((xfile) {
//           //     if (xfile != null) {
//           //       setState(() {
//           //         _pcikedImage = File(xfile.path);
//           //       });
//           //     }
//           //     // 카메라를 촬영 후 해당 팝업을 닫게 처리
//           //     Navigator.maybePop(context);
//           //   });
//           // },
//           onPressed: onPressedCamera,
//           child: const Text('카메라로 촬영'),
//         ),
//         TextButton(
//           // onPressed: () {
//           //   ImagePicker()
//           //       .pickImage(source: ImageSource.gallery)
//           //       .then((xfile) {
//           //     if (xfile != null) {
//           //       //return; //xfile이 null 일경우 pass 처리
//           //       setState(() {
//           //         _pcikedImage = File(xfile.path);
//           //       });
//           //     }
//           //     // 이미지를 선택 후 해당 팝업을 닫게 처리
//           //     Navigator.maybePop(context);
//           //   });
//           // },
//           onPressed: onPressedGallery,
//           child: const Text('앨범에서 가져오기'),
//         ),
//       ],
//     );
//   }
// }
