import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/dialogs/add_food_dialog.dart';
import '../../database/database.dart';
import '../components/buttons/icon_toggle_button.dart';
import '../components/food/nutrition.dart';
import '../components/side_menu.dart';

class FoodInfoScreen extends StatefulWidget {
  FoodInfoScreen({super.key, required this.food});

  final Food food;
  final UserService userService = Get.find<UserService>();

  @override
  State<FoodInfoScreen> createState() => _FoodInfoScreenState();
}

class _FoodInfoScreenState extends State<FoodInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _showProgress(context, false);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) return _showProgress(context, true);
              return _showInfo(context, snapshot);
            }

            return _showProgress(context, false);
          }
      );
    });
  }

  Widget _showProgress(BuildContext context, bool showError) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
        ),
        body: showError ?
        const Center(child: Text("An error occurred while loading data!"))
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Nutrition(food: widget.food),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.food.description,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _showInfo(BuildContext context, AsyncSnapshot<bool> snapshot) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Text(widget.food.name),
                ),
                const Spacer(),
                IconToggleButton(
                  initialValue: snapshot.data ?? false,
                  isToggledIcon: Icon(Icons.favorite_rounded, color: theme.colorScheme.onPrimary, size: 30,),
                  notToggledIcon: Icon(Icons.favorite_border_rounded, color: theme.colorScheme.onPrimary, size: 30),
                  onChanged: onLike,
                ),
                IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AddFoodDialog(food: widget.food, dateTime: DateTime.now())
                  ),
                  icon: Icon(Icons.add,
                      size: 30, color: theme.colorScheme.onPrimary),
                )
              ],
            )
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Nutrition(food: widget.food),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.food.description,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Future<bool> getData() async {
    return await widget.userService.isLoggedInUsersFoodFavorite(widget.food.id);
  }

  void onLike(bool value) async {
    try {
      if (value) {
        await widget.userService.addLoggedInUsersFoodToFavorites(widget.food.id);
      } else {
        await widget.userService.removeLoggedInUsersFoodFromFavorites(widget.food.id);
      }
    } catch (err) {
      print("An error has occurred while removing or adding food to favorites!: $err");
    }
  }

}
