import 'package:flutter/material.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';

import 'meal_item.dart';

class MealsCard extends StatefulWidget{

  const MealsCard({super.key, required this.typeOfMeal});

  final TypeOfMeal typeOfMeal;

  @override
  State<MealsCard> createState() => _MealsCard();

}

class _MealsCard extends State<MealsCard> {

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle style = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Card(
      color: colorScheme.onSecondary,
      child: Padding(
        padding: EdgeInsetsDirectional.all(8.0),
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
                    icon: const Icon(Icons.menu_rounded)
                )
              ],
            ),
            Column(children: generateMealItems(_isExpanded))
          ],
        ),
      ),
    );

  }

  List<Widget> generateMealItems(bool isExpanded) {
      List<MealItem> mealItems = [
        MealItem(mealName: "Banana", amount: 3),
        MealItem(mealName: "Strawberries", amount: 2),
      ];

      if (isExpanded) {
          return mealItems;
      }
      return List.empty();
  }

}

