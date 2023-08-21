import 'package:flutter/material.dart';
// import 'package:flutter_image_picker/page/home_page.dart';
import 'package:flutter_image_picker/page/image_page.dart';

/*
  image picker 사용하기
  image picker 로컬 캐시에 임시적으로 처리를 하므로 처리한 이미지를 갤러리에 
  저장을 하거나 해야 영구 저장이 된다.

  안드로이드에서는 더 이상 권한 설정에 대한 별도의 작업이 필요 없지만
  ios에서는 
  NSCameraUsageDescription : 카메라
  NSPhotoLibraryUsageDescription : 갤러리
  에 대한 접근 권한 설정이 필요하다.

*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ImagePage(),
    );
  }
}
