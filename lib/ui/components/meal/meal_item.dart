import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';

class MealItem extends StatefulWidget {
  MealItem({
    super.key,
    required this.usersPlannedMeal,
  });

  final UsersPlannedMeal usersPlannedMeal;
  final UserService userService = Get.find<UserService>();
  final FoodsService foodsService = Get.find<FoodsService>();

  @override
  State<MealItem> createState() => _MealItem();
}

class _MealItem extends State<MealItem> {

  bool _isChecked = false;

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
                  const LinearProgressIndicator();
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasError && snapshot.hasData) return snapshot.data!;

                  return const Center(child: Text("Error occurred while loading data!"),);
                }

                return const LinearProgressIndicator();
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


class FoodItem extends StatefulWidget {
  const FoodItem({
    super.key,
    required this.food,
    required this.amount,
    required this.isChecked,
  });

  final Food food;
  final int amount;
  final bool isChecked;


  @override
  State<StatefulWidget> createState() => _FoodItem();
}

class _FoodItem extends State<FoodItem> {

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    if (widget.isChecked) _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface
    );

    return Row(
      children: [
        Checkbox(
            autofocus: true,
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue!;
              });
            }),
        Text(widget.amount.toString(), style: style),
        const Icon(Icons.close_rounded, size: 15),
        const Spacer(flex: 1),
        Text(widget.food.name, style: style),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)
        )
      ],
    );
  }

}

class UsersMealItem extends StatefulWidget {
  const UsersMealItem({
    super.key,
    required this.usersMeal,
    required this.amount,
    required this.isChecked,
  });

  final UsersMeal usersMeal;
  final int amount;
  final bool isChecked;


  @override
  State<StatefulWidget> createState() => _UsersMealItem();
}

class _UsersMealItem extends State<UsersMealItem> {

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    if (widget.isChecked) _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface
    );

    return Row(
      children: [
        Checkbox(
            autofocus: true,
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue!;
              });
            }),
        Text(widget.amount.toString(), style: style),
        const Icon(Icons.close_rounded, size: 15),
        const Spacer(flex: 1),
        Text(widget.usersMeal.name, style: style),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)
        )
      ],
    );
  }

}
