import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:intl/intl.dart';

/*
  2023.09.12

  알림 처리를 위한 ios, android 권한 관련 설정을 위한 서비스 

  안드로이드 13 (API level 33) 이하는 별도의 권한 요청이 없어도 되나
  이후 부터는 ios처럼 권한을 받아야 정상적으로 알림이 동작 된다.
*/

final notification = FlutterLocalNotificationsPlugin();

class JavadoriNotification {
  // JavadoriNotification._();

  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> initializeNotification() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await notification.initialize(initializationSettings);
  }

  Future<bool> get permissionNotification async {
    /*
    안드로이드 13 (API level 33) 에서는 IOS와 같이 requestPermissions으로 권한을
    받아야 알림이 정상적으로 동작한다.
    */
    if (Platform.isAndroid) {
      return await notification
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestPermission() ??
          false;
    } else if (Platform.isIOS) {
      return await notification
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
          false;
    } else {
      return false;
    }
  }

  // 알림 세부 내역
  NotificationDetails _notificationDetails(String id,
      {required String title, required String body}) {
    final android = AndroidNotificationDetails(id, title,
        channelDescription: body,
        importance: Importance.max,
        priority: Priority.max);

    // const ios = IOSNotificationDetails();
    const ios = DarwinNotificationDetails(badgeNumber: 1);

    return NotificationDetails(
      android: android,
      iOS: ios,
    );
  }

  String alarmId(int medicineId, String alarmTime) {
    return medicineId.toString() + alarmTime.replaceAll(':', '');
  }

  /*
    2023.09.14
    알람의 id 값 unique 하게 만들기
    
    알림의 id 값은 unique 한 값이여 하지만 시간데이터로만 처리시 동일 시간대에
    하나만 등록 가능하게 되므로 medicineId 필드를 추가해서 
    medicineId 와 alarmTimeStr 값을 조합하여 유니크한 값이 되도록 
    소스를 수정 처리
  */
  Future<bool> addNotification({
    required int medicineId,
    required String alarmTimeStr,
    required String title, // HH:mm 약 먹을 시간이에요!
    required String body, // {약이름} 복약했다고 알려주세요!
  }) async {
    if (!await permissionNotification) {
      // permission_handler 패키지를 설치해야 한다.
      // show native setting page
      return false;
    }

    // 예외처리
    /*
      현재 시간 보다 지났을 경우 다음날 알람이 처리가 되도록 설정
    */
    final now = tz.TZDateTime.now(tz.local);
    final alarmTime = DateFormat('HH:mm').parse(alarmTimeStr);
    final day = (alarmTime.hour < now.hour ||
            alarmTime.hour == now.hour && alarmTime.minute <= now.minute)
        ? now.day + 1
        : now.day;

    /// id
    /*
      id 값을 unique 한 값이여야 함으로 alarmTime을 숫자 형식으로 변환하여 
      unique 하게 유지하도록 처리
    */
    // final alarmTimeId =
    //     DateFormat('HH:mm').format(alarmTime).replaceAll(':', '');
    // String alarmTimeId = alarmTimeStr.replaceAll(':', '');
    // alarmTimeId = medicineId.toString() + alarmTimeId;
    String alarmTimeId = alarmId(medicineId, alarmTimeStr);

    final detail = _notificationDetails(
      alarmTimeId, // unique
      title: title,
      body: body,
    );

    await notification.zonedSchedule(
      int.parse(alarmTimeId), // unique 08:00 -> 800 -> id값+800 으로 유니크하게
      title,
      body,
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        day,
        alarmTime.hour,
        alarmTime.minute,
      ),
      detail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      //payload: DateFormat('HH:mm').format(alarmTime),
      payload: alarmTimeId,
    );

    log('[notification list] ${await pendingNotificationIds}');

    return true;
  }

  /*
    2023.10.11
    
    다중 알람을 삭제하기 위한 삭제용 메서드
    알람의 List 값을 받아서 알람 정보를 삭제 처리 한다.
  */
  // Future<void> deleteMultipleAlarm(List<String> alarmIds) async {
  Future<void> deleteMultipleAlarm(Iterable<String> alarmIds) async {
    log('[before delete notification list] ${await pendingNotificationIds}');
    for (final alarmId in alarmIds) {
      final id = int.parse(alarmId);
      await notification.cancel(id);
    }
    log('[after delete notification list] ${await pendingNotificationIds}');
  }

  /* 
    pendingNotificationRequests의 list 타입의 객체를 반환 한다.
    id 값을 받아서 로그로 기록하기 위해서 id 값을 반환
  */
  Future<List<int>> get pendingNotificationIds {
    final list = notification
        .pendingNotificationRequests()
        .then((value) => value.map((e) => e.id).toList());
    return list;
  }
}
