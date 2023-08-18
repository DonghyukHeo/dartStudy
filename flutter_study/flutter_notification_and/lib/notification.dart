import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone_web.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    //TZDateTime 은 기본 설정이 utc로 되어져 있기 때문에 반드시 지역을 설정해줘야 한다.
    tz.initializeTimeZones();
    // 'Asia/Seoul'
    // tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    // 특정 지역을 고정하기 보다는 실행 지역에 따라서 자동으로 설정할려면 아래와 같이 처리
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    /* 
      안드로이드 13 (API level 33) 에서는 IOS와 같이 requestPermissions으로 권한을
      받아야 알림이 정상적으로 동작한다.
    */
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    // await flutterLocalNotificationsPlugin.show(
    //     0, 'test title', 'test body', notificationDetails,
    //     payload: 'item x');
    // 타임존 셋팅 필요
    final now = tz.TZDateTime.now(tz.local);
//var notiDay = now.day;

// 예외처리
/* 
  현재 시간 보다 지났을 경우 다음날 알람이 처리가 되도록 설정
*/
// if (now.hour > hour || now.hour == hour && now.minute >= minute) {
//   notiDay = notiDay + 1;
// }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'alarmTitle',
      'alarmDescription',
      tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        //notiDay,
        now.day,
        //hour,
        now.hour,
        //minute,
        now.minute,
      ),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      //payload: DateFormat('HH:mm').format(alarmTime),
    );
  }
}
