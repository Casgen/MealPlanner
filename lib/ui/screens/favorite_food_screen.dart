import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/side_menu.dart';
import 'package:umte_project/ui/dialogs/add_food_dialog.dart';
import 'package:umte_project/ui/dialogs/add_meal_dialog.dart';
import 'package:umte_project/ui/dialogs/create_new_meal.dart';
import 'package:umte_project/ui/screens/food_info_screen.dart';
import 'package:umte_project/ui/screens/users_meal_screen.dart';

class YourFavoriteFoodsScreen extends StatefulWidget {
  const YourFavoriteFoodsScreen({super.key});

  @override
  State<YourFavoriteFoodsScreen> createState() => _YourFavoriteFoodsScreen();
}

class _YourFavoriteFoodsScreen extends State<YourFavoriteFoodsScreen> {
  final UserService userService = Get.find<UserService>();
  bool _triggerRebuild = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: Row(
              children: [
                const Text("Your Favorite Foods"),
              ],
            )),
        body: FutureBuilder(
            future: userService.getLoggedInUsersFavoriteFoods(),
            builder: (context, AsyncSnapshot<List<Food>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && !snapshot.hasError) {
                  return _createListView(context, snapshot);
                }

                return const Center(
                    child: Text("An error occurred while loading the data!"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: CircularProgressIndicator());
            }),
      );
    });
  }

  Widget _createListView(
      BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
    if (snapshot.data!.isEmpty) {
      return const Center(
          child: Text("You don't have any of your favorite meals yet!"));
    }

    List<Widget> listTiles = snapshot.data!.map((item) {
      return ListTile(
          key: Key(item.id.toString()),
          title: Row(
            children: [
              Text(item.name),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (builder) => AddFoodDialog(
                          food: item,
                          dateTime: DateTime.now(),
                          key: Key(item.id.toString()),
                        ));
                  },
                  icon: const Icon(Icons.calendar_month_rounded))
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => FoodInfoScreen(
                  food: item,
                )));
          });
    }).toList();

    return ListView(
      children: listTiles,
    );
  }
}
