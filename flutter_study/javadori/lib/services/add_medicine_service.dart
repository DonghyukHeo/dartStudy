// import 'package:flutter/cupertino.dart';
// ChangeNotifier 를 사용하기 위해서 material.dart 보다 foundation.dart 를 import 한다.
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../main.dart';

/*
  2023.09.11
  서비스 로직의 분리
  
  하나의 소스에 기능을 구현한 것을 별도의 서비스 로직으로 분리하여
  서비스 부분을 하나의 class로 만든다.

  2023.10.16
  수정화면을 통해서 들어온 경우에는 생성자에 updateMedicineId 값을 받아서
  초기화 한 후 등록된 알람 정보값으로 생성하여 수정화면으로 만들어준다.
*/
// class AddMedicineService {
// 화면 변환을 위해서 with ChangeNotifier 해준다.
class AddMedicineService with ChangeNotifier {
  // 수정화면일 경우에는 생성자를 통해서 수정된 정보로 초기화 처리 한다.
  AddMedicineService(int updateMedicineId) {
    final isUpdate = updateMedicineId != -1;
    //수정시에는 초기값을 초기화를 먼저 한다.
    if (isUpdate) {
      final updateAlarms = medicineRepository.medicineBox.values
          .singleWhere((medicine) => medicine.id == updateMedicineId)
          .alarms;

      _alarms.clear();
      _alarms.addAll(updateAlarms);
    }
  }

  final _alarms = <String>{
    '08:00',
    '13:00',
    '18:00',
  };

  /*
    _alarms map 처리를 해야 되기 때문에 _alarms이 새로운 것으로 대체 되면 안되므로
    getter를 만들어준다. 
  */
  // Set<String> get alarms => _alarms;
  List<String> get alarms => _alarms.toList();

  void addNowAlarm() {
    final now = DateTime.now();
    final nowTime = DateFormat('HH:mm').format(now);

    _alarms.add(nowTime);
    //setState 대신에 ChangeNotifier에서는 notifyListeners 를 호출해준다.
    notifyListeners();
  }

  void removeAlarm(String alarmTime) {
    _alarms.remove(alarmTime);
    notifyListeners();
  }

  void setAlarm({required String prevTime, required DateTime setTime}) {
    _alarms.remove(prevTime);
    final setTimeStr = DateFormat('HH:mm').format(setTime);
    _alarms.add(setTimeStr);
    notifyListeners();
  }
}
