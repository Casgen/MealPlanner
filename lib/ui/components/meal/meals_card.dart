import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/tables.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';

import '../../../database/database.dart';
import 'meal_item.dart';

class MealsCard extends StatefulWidget{

  MealsCard({
    super.key,
    required this.typeOfMeal,
    required this.usersPlannedMeal,
  });

  final TypeOfMeal typeOfMeal;
  final UserService userService = Get.find<UserService>();
  final FoodsService foodsService = Get.find<FoodsService>();
  final List<UsersPlannedMeal> usersPlannedMeal;

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
        padding: const EdgeInsetsDirectional.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
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
              if (_isExpanded) Column(children: generateMealItems(),)
            ],
          ),
        ),
      ),
    );

  }

  List<Widget> generateMealItems() {
    List<Widget> mealItems = [];

    if (widget.usersPlannedMeal.isEmpty) {
      mealItems.add(const Center(child: Text("Nothing to see here...")));
      return mealItems;
    }

    for (UsersPlannedMeal plannedMeal in widget.usersPlannedMeal) {
      mealItems.add(MealItem(usersPlannedMeal: plannedMeal));
    }

    return mealItems;
  }

}

