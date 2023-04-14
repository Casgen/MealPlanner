import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/ui/components/meal/meal_widget.dart';
import 'package:umte_project/ui/screens/hydration_screen.dart';

import '../home_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              child: Text("Menu",
                  style: theme.textTheme.displaySmall!
                      .copyWith(color: theme.colorScheme.onPrimary))
          ),
          MenuItem(text: "Home", icon: Icons.home, onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyHomePage()));
          }),
          MenuItem(text: "Food Menu", icon: Icons.restaurant_menu, onTap: () {}),
          MenuItem(text: "Hydration", icon: Icons.water_drop, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HydrationScreen())
            );
          }),
          MenuItem(text: "Your meals",icon: Icons.menu_book, onTap: () {}),
          MenuItem(text: "Database",icon: Icons.data_array, onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return DriftDbViewer(Get.find<UMTEDatabase>());
                })
            );
          }),
          MenuItem(text: "Test Data",icon: Icons.data_array, onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  Food? food;
                  Get.find<UMTEDatabase>().foodsDao.getFood(1).then((value) {
                    food = value;
                  });
                  return Text(food != null ? "Nothing" : food!.name);
                })
            );
          })
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap
  });

  final String text;
  final double menuIconSize = 20.0;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return ListTile(
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: menuIconSize,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(text, style: style),
        ],
      ),
    );
  }
}
