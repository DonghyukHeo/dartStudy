import 'dart:io';

import 'package:path_provider/path_provider.dart';

/*
  2023.09.13
  이미지 파일 저장하기

  이미지 파일의 로컬 저장을 위한 경로 정보를 위한 함수
  path_provider 패키지를 설치를 먼전 선행해야 한다.
*/

Future<String> saveImageToLocalDirectory(File image) async {
  final doucmentDirectory = await getApplicationDocumentsDirectory();
  final folderPath = doucmentDirectory.path + '/medicien/images';
  final filePath = folderPath + '/${DateTime.now().microsecondsSinceEpoch}.png';

  await Directory(folderPath).create(recursive: true);

  final newFile = File(filePath);
  newFile.writeAsBytesSync(image.readAsBytesSync());

  return filePath;
}

void deleteImage(String filePath) {
  // recursive가 true이면 하위에 정보까지 삭제 처리한다.
  File(filePath).delete(recursive: true);
}
