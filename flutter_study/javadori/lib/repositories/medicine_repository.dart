import 'dart:developer';

import 'package:hive/hive.dart';

import '../models/medicine.dart';
import 'javadori_hive.dart';

/*
  Hive a
*/

class MedicineRepository {
  Box<Medicine>? _medicineBox; //멤버 변수

  // hive 가 수행이 된 후에 Box를 읽어야 하기 때문에 get를 별도로 만들어서 처리 하도록 한다.
  Box<Medicine> get medicineBox {
    _medicineBox ??= Hive.box<Medicine>(JavadoriHiveBox.medicine);
    // if (_medicineBox == null) {
    //   _medicineBox = Hive.box<Medicine>(JavadoriHiveBox.medicine);
    // }
    return _medicineBox!;
  }

  void addMedicine(Medicine medicine) async {
    int key = await medicineBox.add(medicine); // key 값이 자동 생성

    // log 출력
    log('[addMedicine] add (key:$key) $medicine');
    log('result ${medicineBox.values.toList()}');
  }

  void deleteMedicine(int key) async {
    await medicineBox.delete(key);

    log('[deleteMedicine] delete (key:$key)');
    log('result ${medicineBox.values.toList()}');
  }

  void updateMedicine({
    required int key,
    required Medicine medicine,
  }) async {
    await medicineBox.put(key, medicine);

    log('[updateMedicine] update (key:$key) $medicine');
    log('result ${medicineBox.values.toList()}');
  }

  // id 값을 생성해서 전달하는 getter
  int get newId {
    final lastId = medicineBox.values.isEmpty ? 0 : medicineBox.values.last.id;
    return lastId + 1;
  }
}
