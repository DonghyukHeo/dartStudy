import 'package:flutter/material.dart';

/* 
  20233.08.09

  이미지 출력 위젯

  asset : 로컬이미지 
  이미지 경로를 확인할때는 "상대경로 복사" 메뉴를 통해서 확인
  ==> pubspec.yaml 파일에서 flutter: 항목의 assets 부분의 주석을 제거하고 이미지 경로를 추가한다.
  개별적 이미지를 여러개 추가할 경우 일일이 등록하는 것 보다 해당 경로까지만 작성하여 경로를 바라보게 하면 된다.
  참고 : SingleChildScrollView 로 감싸 주면 화면 overflow가 되는것을 스크롤로 변경하여 볼 수 있게 할 수 있다.
  
  network : 네트워크 이미지
  ==> 인터넷 연결이 되어져 있어야 하며, asset 이미지보다 출력이 느리다.

  file : 파일 이미지
  ==> 갤러리나 외부 파일을 출력할 때 사용되며, file 타입을 인자로 사용한다.

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
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const _ImageHomePage(),
    );
  }
}

class _ImageHomePage extends StatelessWidget {
  const _ImageHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Image.file(file),
            Image.network(
              'https://img.khan.co.kr/news/2023/01/02/news-p.v1.20230102.1f95577a65fc42a79ae7f990b39e7c21_P1.webp',
              width: 300,
              height: 300,
              fit: BoxFit.fill, // width, height에 딱 맞추어서 채울때(이미지 왜곡이 생김)
            ),
            Image.network(
              'https://thumbs.gfycat.com/AdoredDeadDeermouse-size_restricted.gif',
              width: 300,
              height: 300,
              fit: BoxFit.contain, // 이미지 자체의 비율을 유지하게 적용
            ),
            Image.asset(
              'assets/image/image.png',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            Image.asset(
              'assets/image/image2.gif',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            Image.asset('assets/image/image3.gif'),
          ],
        ),
      ),
    );
  }
}
