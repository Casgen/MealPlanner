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
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Card(
      color: colorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.typeOfMeal.getName(), style: style,),
                const Spacer(),
                IconButton(
                    onPressed: () {  },
                    icon: const Icon(Icons.menu_rounded)
                )
              ],
            ),
            Column(children: [
              MealItem(mealName: "Banana", amount: 2),
            ],)
          ],
        ),
      ),
    );

  }

}

