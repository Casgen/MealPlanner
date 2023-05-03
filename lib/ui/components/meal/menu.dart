import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/data/enums/week_day.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/state/nutrition_tracker_state.dart';
import 'package:umte_project/ui/components/nutrition_tracker.dart';

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
    TextStyle style = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    // Provider.of<NutritionTrackerState>(context, listen: false).clearArrays();

    return Column(
      children: [
        const Card(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: NutritionTracker(),
        )),
        const SizedBox(height: 10),
        Card(
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(weekday.getName(), style: style),
                      Spacer(),
                      Text(
                          format('{:d}.{:d}.{:04d}', dateTime.day, dateTime.month, dateTime.year),
                          style: style,
                      )
                    ],
                  ),
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
        ),
      ],
    );
  }

  Future<List<UsersPlannedMeal>> getUsersPlannedMeals() async {
    return await userService.getLoggedInUsersPlannedMeals(dateTime);
  }
}
