import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/meal/food_item.dart';
import 'package:umte_project/ui/components/meal/users_meal_item.dart';

import '../../../state/nutrition_tracker_state.dart';

class MenuItem extends StatefulWidget {
  MenuItem({
    super.key,
    required this.usersPlannedMeal,
    required this.typeOfMeal,
    required this.onRemove
  });

  final UsersPlannedMeal usersPlannedMeal;
  final UserService userService = Get.find<UserService>();
  final FoodsService foodsService = Get.find<FoodsService>();
  final void Function() onRemove;
  final TypeOfMeal typeOfMeal;

  @override
  State<MenuItem> createState() => _MenuItem();
}

class _MenuItem extends State<MenuItem> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface
    );

    return Column(
      children: [
        FutureBuilder(
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
      ],
    );
  }

  Future<Widget> _decideItem() async {

    const Widget errorItem = Center(child: Text("Item could not be loaded!"),);

    if (widget.usersPlannedMeal.foodId != null) {
      Food? food = await widget.foodsService.getFoodById(widget.usersPlannedMeal.foodId!);

      if (food != null) {
        return FoodItem(
            food: food,
            amount: widget.usersPlannedMeal.amount,
            isChecked: widget.usersPlannedMeal.isChecked,
            onRemoved: _onFoodRemoved,
        );
      }

      print("Food is null!");
      return errorItem;
    }

    if (widget.usersPlannedMeal.usersMealId != null) {
      UsersMeal? usersMeal = await widget.userService.getUsersMealById(widget.usersPlannedMeal.usersMealId!);

      if (usersMeal != null) {
        return UsersMealItem(
            usersMeal: usersMeal,
            amount: widget.usersPlannedMeal.amount,
            isChecked: widget.usersPlannedMeal.isChecked,
            onRemoved: _onMealRemoved,
        );
      }

      print("User's meal is null!");
      return errorItem;
    }

    return const Center(
      child: Text("An error occurred! both food and user's meal is null!"),);
  }

  Future<bool> _onMealRemoved(UsersMeal usersMeal) async {

    try {
      await widget.userService.removeUsersPlannedMeal(widget.usersPlannedMeal);

      if (!context.mounted) return false;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Meal removed from menu"),
        ));

      widget.onRemove();

      return true;

    } catch (err) {
      print("An error occurred while removing users meal from menu!");

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Error occured while removing meal from menu!"),
        ));

      return false;
    }

  }

  Future<bool> _onFoodRemoved(Food food) async {

    try {
      await widget.userService.removeUsersPlannedMeal(widget.usersPlannedMeal);

      if (!context.mounted) return false;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Meal removed from menu"),
        ));

      widget.onRemove();
      return true;

    } catch (err) {
      print("An error occurred while removing users meal from menu!");
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Error occured while removing meal from menu!"),
        ));

      return false;
    }

  }

}
