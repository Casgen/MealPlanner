import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/data/enums/week_day.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';

import 'menu_card.dart';

class Menu extends StatelessWidget {
  Menu(this.dateTime, {super.key})
      : weekday = WeekDay.fromValue(dateTime.weekday);

  final DateTime dateTime;
  final WeekDay weekday;
  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.headlineLarge!.copyWith(
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
            FutureBuilder(
                future: getUsersPlannedMeals(),
                builder:
                    (context, AsyncSnapshot<List<UsersPlannedMeal>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && !snapshot.hasError) {
                      return Column(
                        children: TypeOfMeal.values
                            .map((el) => MenuCard(
                                  typeOfMeal: el,
                                  dateTime: dateTime,
                                  usersPlannedMeals: snapshot.data!
                                      .where(
                                          (element) => element.typeOfMeal == el)
                                      .toList(),
                                ))
                            .toList(),
                      );
                    }

                    return const Center(
                        child:
                            Text("An error occurred while loading the data!"));
                  }

                  return const Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }

  Future<List<UsersPlannedMeal>> getUsersPlannedMeals() async {
    return await userService.getLoggedInUsersPlannedMeals(dateTime);
  }
}
