import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:javadori/models/medicine_alarm.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    super.key,
    required this.imagePath,
    // required this.medicineAlarm,
  });

  // final MedicineAlarm medicineAlarm;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Center(
        child: Image.file(
          // File(medicineAlarm.imagePath!),
          File(imagePath),
        ),
      ),
    );
  }
}
