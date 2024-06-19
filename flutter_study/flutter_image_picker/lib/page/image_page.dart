import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
  2023.08.21
  갤러리 및 카메라 접근하기

  image_picker 패키지 이용
  ImageSource.gallery : 갤러리에 대한 접근
  ImageSource.camera : 카메라에 대한 접근

  안드로이드에서는 해당 권한에 대한 추가적인 설정이 없지만 
  ios에서는 NSCameraUsageDescription, NSPhotoLibraryUsageDescription 에 대한
  설정을 info.plist 에 처리해줘야 한다.
*/
class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // 이미지를 선택해서 출력할 경우 화면이 변경된 것을 처리하기 위해 setState를 호출
                  setState(() {
                    _image = File(image.path);
                  });
                }

                // print('image $image');
              },
              child: const Text('Gallery 사진 가져오기'),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);

                if (image != null) {
                  // 이미지를 선택해서 출력할 경우 화면이 변경된 것을 처리하기 위해 setState를 호출
                  setState(() {
                    _image = File(image.path);
                  });
                }

                // print('image $image');
              },
              child: const Text('Camera 사진 촬영하기'),
            ),
            _image == null ? const Text('Empty Image') : Image.file(_image!),
          ],
        ),
      ),
    );
  }
}
