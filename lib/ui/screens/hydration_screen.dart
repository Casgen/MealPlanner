import 'dart:math';

import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/hydration/add_liters_button.dart';
import '../components/side_menu.dart';

class HydrationScreen extends StatefulWidget {
  const HydrationScreen({super.key});

  @override
  State<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> {
  double amountDrank = 0.0;
  double amountToBeDrunk = 2.7;

  void addLiters(double liters) {
    setState(() {
      amountDrank = min(amountToBeDrunk, amountDrank + liters);
    });
  }

  void removeLiters(double liters) {
    setState(() {
      amountDrank = max(0.0, amountDrank - liters);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle amountTextStyle = GoogleFonts.barlowCondensed();

    String amountText = format('{:.1f}',amountDrank);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: const Text("Home")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('$amountText/',
                    style: amountTextStyle.copyWith(fontSize: 150)),
                Text("$amountToBeDrunk",
                    style: amountTextStyle.copyWith(fontSize: 40)),
              ],
            ),
            Center(
              child: Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                children: [
                  LitersButton(
                    liters: 0.1,
                    onAddLiters: addLiters,
                    onRemoveLiters: removeLiters,
                  ),
                  LitersButton(
                    liters: 0.3,
                    onAddLiters: addLiters,
                    onRemoveLiters: removeLiters,
                  ),
                  LitersButton(
                    liters: 0.5,
                    onAddLiters: addLiters,
                    onRemoveLiters: removeLiters,
                  ),
                  LitersButton(
                    liters: 1.0,
                    onAddLiters: addLiters,
                    onRemoveLiters: removeLiters,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
