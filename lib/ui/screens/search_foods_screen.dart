import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/foods_service.dart';
import 'package:umte_project/ui/screens/food_info_screen.dart';

import '../components/side_menu.dart';

class SearchFoodsScreen extends StatefulWidget {
  const SearchFoodsScreen({super.key});

  @override
  State<SearchFoodsScreen> createState() => _SearchFoodsScreen();
}

class _SearchFoodsScreen extends State<SearchFoodsScreen> {
  final FoodsService foodsService = Get.find<FoodsService>();

  Timer? timeoutInterval;
  List<Food> foundFoods = List.empty();
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textFieldStyle = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    TextStyle labelStyle = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onPrimary.withAlpha(128));

    return LayoutBuilder(builder: (builder, constraints) {
      return Scaffold(
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
            : ListView(
                children: List.generate(foundFoods.length, (index) {
                  return ListTile(
                    title: Text(foundFoods[index].name),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FoodInfoScreen(food: foundFoods[index])));
                    },
                  );
                }),
              ),
      );
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
}
