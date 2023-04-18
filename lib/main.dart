import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/state/app_state.dart';
import 'package:umte_project/ui/screens/login_screen.dart';

void main() {
  initSingletons();
  runApp(const UMTEApp());
}

void initSingletons() {
  Get.put(UMTEDatabase());
  Get.put(UserService(Get.find<UMTEDatabase>()));
}

class UMTEApp extends StatelessWidget {
  const UMTEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const LoginPage(),
      ),
    );
  }
}


