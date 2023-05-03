import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/notification_service.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/state/app_state.dart';
import 'package:umte_project/state/nutrition_tracker_state.dart';
import 'package:umte_project/ui/screens/home_screen.dart';
import 'package:umte_project/ui/screens/login_screen.dart';


void main() {
  Get.put(UMTEDatabase());
  NotificationService notificationService = NotificationService();
  notificationService.initializePlatformNotifications();
  Get.put(notificationService);
  initSingletons();
  runApp(const UMTEApp());
}

void initSingletons() {
  Get.put(UserService());
  Get.put(FoodsService());
}

class UMTEApp extends StatelessWidget {
  const UMTEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ListenableProvider<AppState>(create: (context) => AppState()),
      ListenableProvider<MenuState>(create: (context) => MenuState())
    ],
      child: MaterialApp(
        title: 'Caloric Tables',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo.shade200),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {

}

void initializeNotifications() async {
}



