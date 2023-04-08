import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umte_project/ui/components/meal/meal_widget.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  final double menuIconSize = 23.0;

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
                      .copyWith(color: theme.colorScheme.onPrimary))),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: menuIconSize,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text("Food menu", style: style),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.water_drop,
                  size: menuIconSize,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text("Hydration", style: style),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book,
                  size: menuIconSize,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text("Your meals", style: style),
              ],
            ),
          )
        ],
      ),
    );
  }

}