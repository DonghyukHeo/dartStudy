import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
