import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/state/app_state.dart';
import 'package:umte_project/state/nutrition_tracker_state.dart';
import 'package:umte_project/ui/screens/login_screen.dart';

void main() {
  Get.put(UMTEDatabase());
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
      ListenableProvider<NutritionTrackerState>(create: (context) => NutritionTrackerState())
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


