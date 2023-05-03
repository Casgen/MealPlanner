import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int incId = 0;
  int amountToBeDrank = 0;

  Future<void> initializePlatformNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("flutter_logo");

    _localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    await _configureLocalTimeZone();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
              print("object");
            });

    scheduleNotifications(5);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("hydrationId", 'hydration',
            channelDescription: "Channel for the hydration notifications",
            importance: Importance.defaultImportance,
        priority: Priority.high,
        playSound: true));
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    incId++;
    return _localNotificationsPlugin.show(
        incId, title, body, await notificationDetails());
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> scheduleNotifications(int amount) async {
    _localNotificationsPlugin.cancelAll();

    DateTime begin = tz.TZDateTime.now(tz.local).copyWith(minute: 0, hour: 7, second: 0);
    DateTime end = tz.TZDateTime.now(tz.local).copyWith(minute: 0, hour: 21, second: 0);

    for (int i = 0; i <= amount; i++) {

      Duration deltaDuration = end.difference(begin);
      double result = end.millisecondsSinceEpoch + (deltaDuration.inMilliseconds * i/5);
      int milliSecondsSinceEpoch = result.toInt();

      if (tz.TZDateTime.now(tz.local).millisecondsSinceEpoch < milliSecondsSinceEpoch) {
        _localNotificationsPlugin.zonedSchedule(
          i,
          "Time to Hydrate!",
          "Drink up!",
          tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, milliSecondsSinceEpoch),
          notificationDetails(),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      }

    }
  }

  Future<void> disableNotification() async {
    _localNotificationsPlugin.cancelAll();
  }
}
