import 'package:flutter/material.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';

import '../../../database/database.dart';
import 'menu_item.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({
    super.key,
    required this.typeOfMeal,
    required this.dateTime,
    required this.usersPlannedMeals,
  });

  final TypeOfMeal typeOfMeal;
  final DateTime dateTime;
  final List<UsersPlannedMeal> usersPlannedMeals;

  @override
  State<MenuCard> createState() => _MealsCard();
}

class _MealsCard extends State<MenuCard> {
  bool _isExpanded = false;
  bool _refresh = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle style = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Card(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.typeOfMeal.getName(), style: style),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: const Icon(Icons.menu_rounded))
              ],
            ),
            _showItems()
          ],
        ),
      ),
    );
  }

  Widget _showItems() {
    if (!_isExpanded) return Column();

    if (widget.usersPlannedMeals.isEmpty) {
      return Column(
        children: const [Text("Nothing to see here...")],
      );
    }

    return Column(
      children: widget.usersPlannedMeals
          .map((e) =>
              MenuItem(usersPlannedMeal: e, typeOfMeal: widget.typeOfMeal, onRemove: () {
                widget.usersPlannedMeals.remove(e);
                setState(() {
                  _refresh = !_refresh;
                });
              },))
          .toList(),
    );
  }
}
