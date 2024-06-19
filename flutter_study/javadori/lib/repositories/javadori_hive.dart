import 'package:hive_flutter/hive_flutter.dart';

import '../models/medicine.dart';
import '../models/medicine_history.dart';

class JavadoriHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());
    Hive.registerAdapter<MedicineHistory>(MedicineHistoryAdapter());

    await Hive.openBox<Medicine>(JavadoriHiveBox.medicine);
    await Hive.openBox<MedicineHistory>(JavadoriHiveBox.medicineHistory);
  }
}

class JavadoriHiveBox {
  static const String medicine = 'medicine';
  static const String medicineHistory = 'medicine_history';
}
