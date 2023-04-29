import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/meal/food_item.dart';
import 'package:umte_project/ui/components/meal/users_meal_item.dart';

class MenuItem extends StatefulWidget {
  MenuItem({
    super.key,
    required this.usersPlannedMeal,
  });

  final UsersPlannedMeal usersPlannedMeal;
  final UserService userService = Get.find<UserService>();
  final FoodsService foodsService = Get.find<FoodsService>();

  @override
  State<MenuItem> createState() => _MealItem();
}

class _MealItem extends State<MenuItem> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface
    );

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _decideItem(),
              builder: (context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: LinearProgressIndicator());
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasError && snapshot.hasData) return snapshot.data!;

                  return const Center(child: Text("Error occurred while loading data!"),);
                }

                return const Center(child: LinearProgressIndicator());
              }
            )
        )
      ],
    );
  }

  Future<Widget> _decideItem() async {

    const Widget errorItem = Center(child: Text("Item could not be loaded!"),);

    if (widget.usersPlannedMeal.foodId != null) {
      Food? food = await widget.foodsService.getFoodById(widget.usersPlannedMeal.foodId);

      if (food != null) {
        return FoodItem(
            food: food,
            amount: widget.usersPlannedMeal.amount,
            isChecked: widget.usersPlannedMeal.isChecked
        );
      }

      print("Food is null!");
      return errorItem;
    }

    if (widget.usersPlannedMeal.usersMealId != null) {
      UsersMeal? usersMeal = await widget.userService.getUsersMealById(widget.usersPlannedMeal.foodId);

      if (usersMeal != null) {
        return UsersMealItem(
            usersMeal: usersMeal,
            amount: widget.usersPlannedMeal.amount,
            isChecked: widget.usersPlannedMeal.isChecked
        );
      }

      print("User's meal is null!");
      return errorItem;
    }

    return const Center(
      child: Text("An error occurred! both food and user's meal is null!"),);
  }

}






