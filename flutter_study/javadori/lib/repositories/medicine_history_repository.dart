import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:javadori/models/medicine_history.dart';

import 'javadori_hive.dart';

/*
  2023.09.25
  
  약을 복용한 내용에 대한 history를 위한 Repository class
  Hive Box에 history 내용 처리
*/

class MedicineHistoryRepository {
  Box<MedicineHistory>? _historyBox; //멤버 변수

  // hive 가 수행이 된 후에 Box를 읽어야 하기 때문에 get를 별도로 만들어서 처리 하도록 한다.
  Box<MedicineHistory> get historyBox {
    _historyBox ??= Hive.box<MedicineHistory>(JavadoriHiveBox.medicineHistory);
    return _historyBox!;
  }

  void addHistory(MedicineHistory history) async {
    int key = await historyBox.add(history); // key 값이 자동 생성

    // log 출력
    log('[addHistory] add (key:$key) $history');
    log('result ${historyBox.values.toList()}');
  }

  void deletHistory(int key) async {
    await historyBox.delete(key);

    log('[deletHistory] delete (key:$key)');
    log('result ${historyBox.values.toList()}');
  }

  void deletAllHistory(Iterable<int> keys) async {
    await historyBox.deleteAll(keys);

    log('[deletHistory] delete (key:$keys)');
    log('result ${historyBox.values.toList()}');
  }

  void updateHistory({
    required int key,
    required MedicineHistory history,
  }) async {
    await historyBox.put(key, history);

    log('[updateHistory] update (key:$key) $history');
    log('result ${historyBox.values.toList()}');
  }
}
