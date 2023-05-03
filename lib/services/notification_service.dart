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

    //scheduleNotifications();
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

  Future<void> scheduleNotifications() async {
    return _localNotificationsPlugin.zonedSchedule(
      0,
      "Time to Hydrate!",
          "Drink up!",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
