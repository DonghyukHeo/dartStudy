/*
  2023.09.18

  목록 화면 구현을 위한 Model 만들기

  목록 화면에서 등록한 순서가 아닌 각 시간대별 목록을 출력해야 함으로
  알람 정보에 대한 model을 만들어 준다.
*/

class MedicineAlarm {
  MedicineAlarm({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.alarmsTime,
    required this.key,
  });

  final int id;
  final String name;
  final String? imagePath;
  final String alarmsTime;
  final int key;
}
