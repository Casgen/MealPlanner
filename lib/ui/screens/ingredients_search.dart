import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/state/app_state.dart';
import 'package:umte_project/ui/components/items/search_food_item.dart';

import '../components/side_menu.dart';

class SearchIngredientsScreen extends StatefulWidget {
  SearchIngredientsScreen({
    super.key,
    required this.usersMeal,
    required this.onConfirm,
  });

  final UsersMeal usersMeal;
  final UserService userService = Get.find<UserService>();
  final void Function() onConfirm;

  @override
  State<SearchIngredientsScreen> createState() => _SearchIngredientsScreen();
}

class _SearchIngredientsScreen extends State<SearchIngredientsScreen> {
  final FoodsService foodsService = Get.find<FoodsService>();

  Timer? timeoutInterval;
  bool showProgress = false;
  bool showConfirmProgress = true;

  List<Food> foodIngredients = List.empty();
  List<Food> foundFoods = List.empty();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textFieldStyle = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    TextStyle labelStyle = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onPrimary.withAlpha(128));

    return LayoutBuilder(builder: (builder, constraints) {
      return Consumer<AppState>(builder: (context, appState, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  _onConfirm(context, appState),
              backgroundColor: theme.colorScheme.primary,
              child: showConfirmProgress
                  ? Icon(Icons.done_rounded, color: theme.colorScheme.onPrimary)
                  : CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary,
                    )),
          drawer: const SideMenu(),
          appBar: AppBar(
              iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
              backgroundColor: theme.primaryColor,
              titleTextStyle: theme.textTheme.headlineSmall!
                  .copyWith(color: theme.colorScheme.onPrimary),
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  style: textFieldStyle,
                  onChanged: timeoutSearch,
                  decoration: InputDecoration(
                      iconColor: theme.colorScheme.onPrimary,
                      icon: const Icon(Icons.search),
                      border: const UnderlineInputBorder(),
                      labelStyle: labelStyle,
                      labelText: "Search..."),
                ),
              )),
          body: showProgress
              ? const Center(child: CircularProgressIndicator())
              : ListView(children: _generateItems()),
        );
      });
    });
  }

  void searchFoods(String query) async {
    List<Food> foods = await foodsService.searchFoods(query);

    setState(() {
      foundFoods = foods;
      showProgress = false;
    });
  }

  void timeoutSearch(String value) {
    if (timeoutInterval != null && timeoutInterval!.isActive) {
      timeoutInterval!.cancel();
    }
    Timer(const Duration(seconds: 1), () => searchFoods(value));
    setState(() {
      showProgress = true;
    });
  }

  List<Widget> _generateItems() {

    return foundFoods
        .map((food) => SearchFoodItem(
            addMode: true,
            food: food,))
        .toList();
  }

  void _onConfirm(BuildContext context, AppState appState) async {
    try {
      setState(() {
        showConfirmProgress = true;
      });

      await widget.userService.addFoodIngredientsToUsersMeal(
          widget.usersMeal, appState.foodIngredients);

      appState.clearFoodIngredients();

      Navigator.pop(context);

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Ingredients succesfully added!")));

      setState(() {
        showConfirmProgress = false;
      });
    } catch (err) {
      setState(() {
        showConfirmProgress = false;
      });

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text("An error occurred while saving ingredients!")));
    }
  }
}
