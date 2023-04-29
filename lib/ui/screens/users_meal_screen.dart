import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/items/ingredient_item.dart';
import 'package:umte_project/ui/components/side_menu.dart';

class UsersMealScreen extends StatefulWidget {
  UsersMealScreen({
    super.key,
    required this.usersMeal,
  });

  final UsersMeal usersMeal;
  final UserService _userService = Get.find<UserService>();

  @override
  State<UsersMealScreen> createState() => _UsersMealScreen();
}

class _UsersMealScreen extends State<UsersMealScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(builder: (builder, constraints) {
      return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: Text(widget.usersMeal.name)),
        body: FutureBuilder(
            future: _createFoodList(),
            builder: (context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && !snapshot.hasError) {
                  return snapshot.data!;
                }

                return const Center(
                    child: Text("An error occured while loading the data!"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: CircularProgressIndicator());
            }),
      );
    });
  }

  Future<Widget> _createFoodList() async {
    List<UsersMealsIngredient> ingredients = await widget._userService
        .getIngredientsFromUsersMeal(widget.usersMeal.id);
    List<Food> foods =
        await widget._userService.getFoodsFromUsersMeal(widget.usersMeal.id);

    if (foods.length != ingredients.length) {
      return const Center(
          child: Text(
              "Failed to fetch data! the number of ingredients and foods do not match!"));
    }

    if (ingredients.isEmpty) {
      return const Center(child: Text("No ingredients added yet"));
    }

    List<Widget> ingredientsItems = List.empty();

    for (int i = 0; i < ingredients.length; i++) {
      ingredientsItems.add(ListTile(
        key: Key('${ingredients[i].id}-tile'),
        title: IngredientItem(
          key: Key(ingredientsItems.toString()),
          food: foods[i],
          ingredient: ingredients[i],
        ),
      ));
    }

    return ListView(children: ingredientsItems);
  }
}
