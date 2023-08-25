import 'package:hive_flutter/adapters.dart';

/*
  hive generator가 읽을 수 있는 모델 객체 생성을 위한 파일
  아래 생성 명령어를 통해서 생성한다.

  flutter packages pub run build_runner build
  
  아래 파일명이 자동생성이 된다.

  객체의 key에 접근하기 위해서는 extends HiveObject 처리를 해줘야 한다.
*/
part 'inputform.g.dart';

@HiveType(typeId: 1)
class InputForm extends HiveObject {
  InputForm({
    required this.name,
    required this.age,
  });

  @HiveField(0) // 필드의 번호가 유니크해야 한다.
  String name;

  @HiveField(1)
  int age;
}
