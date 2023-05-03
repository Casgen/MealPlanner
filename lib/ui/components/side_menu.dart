import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/ui/screens/favorite_food_screen.dart';
import 'package:umte_project/ui/screens/hydration_screen.dart';
import 'package:umte_project/ui/screens/your_meals_screen.dart';

import '../screens/search_foods_screen.dart';
import '../screens/home_screen.dart';

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
          MenuItem(text: "Home", icon: Icons.home, onTap: () => navigateTo(context, HomeScreen())),
          MenuItem(text: "Foods", icon: Icons.restaurant_rounded, onTap: () => navigateTo(context, SearchFoodsScreen())),
          MenuItem(text: "Hydration", icon: Icons.water_drop, onTap: () => navigateTo(context, const HydrationScreen())),
          MenuItem(text: "Your meals",icon: Icons.menu_book, onTap: () => navigateTo(context, YourMealsScreen())),
          MenuItem(text: "Your favorites",icon: Icons.favorite_rounded, onTap: () => navigateTo(context, const YourFavoriteFoodsScreen())),
          // MenuItem(
          //     text: "Database",
          //     icon: Icons.data_array,
          //     onTap: () => navigateTo(context, DriftDbViewer(Get.find<UMTEDatabase>()))
          // ),
        ],
      ),
    );
  }

  void navigateTo<T extends Widget>(BuildContext context, T page) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page)
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
