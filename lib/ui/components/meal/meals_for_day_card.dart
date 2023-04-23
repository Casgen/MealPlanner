import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/data/enums/week_day.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';

import 'meals_card.dart';

class PlannedMealsForDayCard extends StatelessWidget {

  PlannedMealsForDayCard(this.dateTime, {super.key})
      : weekday = WeekDay.fromValue(dateTime.weekday);

  final DateTime dateTime;
  final WeekDay weekday;
  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: getUsersPlannedMeals(),
      builder: (context, AsyncSnapshot<List<UsersPlannedMeal>> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.connectionState == ConnectionState.done) {

          if (!snapshot.hasError && snapshot.hasData) {
            return generateWidget(context, snapshot.data!);
          }

          return const Center(child: Text("An error occurred while loading data!"),);
        }

        return const Center(child: CircularProgressIndicator(),);
      }

    );
  }

  Widget generateWidget(BuildContext context, List<UsersPlannedMeal> data) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    List<Widget> mealsCards = [];

    for (TypeOfMeal typeOfMeal in TypeOfMeal.values) {
      mealsCards.add(generateMealsCard(typeOfMeal, data));
    }

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
                children: mealsCards,
              )
            ],
          ),
        ),
      );
  }

  Widget generateMealsCard(TypeOfMeal typeOfMeal, List<UsersPlannedMeal> data) {
    data.removeWhere((element) => element.typeOfMeal != typeOfMeal);

    return MealsCard(
      typeOfMeal: typeOfMeal,
      usersPlannedMeal: data,
    );
  }

  Future<List<UsersPlannedMeal>> getUsersPlannedMeals() async {
    return await userService.getLoggedInUsersPlannedMeals(dateTime);
  }

}