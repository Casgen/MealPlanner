import 'package:flutter/material.dart';
import 'package:umte_project/ui/components/meal/menu.dart';
import 'package:umte_project/ui/components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            title: const Text("Home")),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Menu(DateTime.now()),
          )
        ]),
      );
    });
  }
}
