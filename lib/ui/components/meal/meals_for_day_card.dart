import 'package:flutter/material.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/data/enums/week_day.dart';

import '../../../database/database.dart';
import 'meals_card.dart';

class MealsForDayCard extends StatelessWidget {
  
  MealsForDayCard(this.dateTime, {super.key})
      : weekday = WeekDay.fromValue(dateTime.weekday);

  final DateTime dateTime;
  final WeekDay weekday;
  final List<UsersConsumedMeal> foods = [];

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle style = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(weekday.getName(), style: style),
              ],
            ),
            Column(
              children: const [
                MealsCard(typeOfMeal: TypeOfMeal.breakfast),
                MealsCard(typeOfMeal: TypeOfMeal.brunch),
                MealsCard(typeOfMeal: TypeOfMeal.lunch),
                MealsCard(typeOfMeal: TypeOfMeal.snack),
                MealsCard(typeOfMeal: TypeOfMeal.dinner),
                MealsCard(typeOfMeal: TypeOfMeal.lateDinner),
              ],
            )
          ],
        ),
      ),
    );
  }

}