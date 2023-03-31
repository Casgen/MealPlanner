import 'package:flutter/material.dart';
import 'package:umte_project/ui/components/meal/meals_for_day_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    int day = DateTime.now().weekday;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: const Text("Home")),
        body: ListView(children: [MealsForDayCard(DateTime.now())]),
      );
    });
  }
}
