/*
  2023.09.15
  
  Model 데이터 

  hive에 저장하기 위해서 hiveType으로 처리한다.

  모델 생성명령서 처리
  flutter packages pub run build_runner build

  adapters를 사용하기 위해서 HiveObject를 extends 해야 한다.
*/
import 'package:hive/hive.dart';

part 'medicine.g.dart';

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  // id, name, image(optional), alarms

  Medicine({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.alarms,
  });

  // final int id; //unique ai, UUID, millisecondsSinceEpoch, random
  // final String name;
  // final String? imagePath;
  // final Set<String> alarms;

  @HiveField(0)
  final int id; //unique ai, UUID, millisecondsSinceEpoch, random
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? imagePath;
  @HiveField(3)
  final List<String> alarms;
  // final Set<String> alarms;

  @override
  String toString() {
    return '{id : $id, name : $name, imagePath : $imagePath, alarms : $alarms}';
  }
}
