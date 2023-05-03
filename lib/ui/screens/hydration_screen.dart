import 'dart:math';

import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

  @override
  void initState() {
    super.initState();
    _retrieveValue();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle amountTextStyle = GoogleFonts.barlowCondensed();

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
              children: [
                Column(
                  children: [
                    WaterGauge(
                      value: amountDrank,
                      denum: amountToBeDrunk,
                    ),
                  ],
                )
              ],
            ),
            Center(
              child: Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                children: [
                  LitersButton(
                    liters: 0.1,
                    onAddLiters: _addLiters,
                    onRemoveLiters: _removeLiters,
                  ),
                  LitersButton(
                    liters: 0.3,
                    onAddLiters: _addLiters,
                    onRemoveLiters: _removeLiters,
                  ),
                  LitersButton(
                    liters: 0.5,
                    onAddLiters: _addLiters,
                    onRemoveLiters: _removeLiters,
                  ),
                  LitersButton(
                    liters: 1.0,
                    onAddLiters: _addLiters,
                    onRemoveLiters: _removeLiters,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> _retrieveValue() async {
    String key = formatDateTime();
    double? retrievedValue;
    SharedPreferences instance = await SharedPreferences.getInstance();
    retrievedValue = instance.getDouble(key);

    if (retrievedValue != null) {
      setState(() {
        amountDrank = retrievedValue!;
      });
    }
  }

  void _saveValue() async {
    String key = formatDateTime();
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setDouble(key, amountDrank);
  }

  String formatDateTime() {
    DateTime dateTimeNow = DateTime.now();
    String key = format('{:04d}{:02d}{:02d}', dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    return key;
  }

  void _addLiters(double liters) {
    setState(() {
      amountDrank = min(amountToBeDrunk, amountDrank + liters);
    });
    _saveValue();
  }

  void _removeLiters(double liters) {
    setState(() {
      amountDrank = max(0.0, amountDrank - liters);
    });
    _saveValue();
  }


}

class WaterGauge extends StatelessWidget {
  const WaterGauge({required this.value, required this.denum});

  final double value;
  final double denum;

  @override
  Widget build(BuildContext context) {
    TextStyle amountTextStyle =
        GoogleFonts.barlowCondensed().copyWith(fontSize: 60);

    String valueText = format('{:.1f}/{:.1f}', value, denum);

    return SfRadialGauge(
        animationDuration: 1000,
        enableLoadingAnimation: true,
        title: const GaugeTitle(
            text: 'Hydration',
            textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 2.7, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 2.7,
                startWidth: 10,
                color: Colors.grey.shade300,
                endWidth: 10
            ),
          ], pointers: <GaugePointer>[
            RangePointer(
              animationDuration: 1000,
              animationType: AnimationType.easeInCirc,
              value: value,
              gradient: SweepGradient(colors: [
                Colors.lightBlueAccent.shade100,
                Colors.blue,
              ]),
            )
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                  child: Text(valueText.toString(), style: amountTextStyle)),
              angle: 90,
            )
          ])
        ]);
  }
}
