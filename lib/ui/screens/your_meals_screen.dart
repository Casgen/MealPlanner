import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/side_menu.dart';
import 'package:umte_project/ui/screens/users_meal_screen.dart';

class YourMealsScreen extends StatelessWidget {
  YourMealsScreen({super.key});

  final UserService userService = Get.find<UserService>();

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
            title: const Text("Your Meals")),
        body: FutureBuilder(
            future: userService.getLoggedInUsersMeals(),
            builder: (context, AsyncSnapshot<List<UsersMeal>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && !snapshot.hasError) {
                  return _createListView(context, snapshot);
                }

                return const Center(
                    child: Text("An error occured while loading the data!"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Center(child: CircularProgressIndicator());
            }),
      );
    });
  }

  Widget _createListView(
      BuildContext context, AsyncSnapshot<List<UsersMeal>> snapshot) {
    if (snapshot.data!.isEmpty) {
      return Center(
          child: Text("You don't have any of your own meals yet. Add one!"));
    }

    List<Widget> listTiles = snapshot.data!.map((item) {
      return ListTile(
          key: Key(item.id.toString()),
          title: Text(item.name),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => UsersMealScreen(
                      usersMeal: item,
                    )));
          });
    }).toList();

    return ListView(
      children: listTiles,
    );
  }
}
