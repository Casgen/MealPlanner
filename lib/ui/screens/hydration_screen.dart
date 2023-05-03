import 'dart:math';

import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:umte_project/data/enums/unit.dart';
import 'package:umte_project/services/notification_service.dart';
import 'package:umte_project/services/notification_service.dart';
import 'package:umte_project/services/notification_service.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';

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
                Text("Hydration"),
                Spacer(),
                IconButton(onPressed: () {
                  showDialog(context: context, builder: (builder) => NotificationDialog());
                }, icon: const Icon(Icons.notifications))
              ],
            )
        ),
        body: ListView(
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

class NotificationDialog extends StatefulWidget {
  NotificationDialog({super.key});

  final NotificationService notificationService = Get.find<NotificationService>();

  @override
  State<NotificationDialog> createState() => _NotificationDialog();

}

class _NotificationDialog extends State<NotificationDialog> {

  int _amount = 5;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AmountCounter(
                unit: Unit.times,
                onChanged: (value) {
                  setState(() {
                    _amount = value;
                  });
                },
                limit: 499,
                initialValue: _amount,
              ),
            ),
            FilledButton(onPressed: () {
              widget.notificationService.scheduleNotifications(_amount);

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text("Notifications set."),
                ));

              Navigator.pop(context);
            }, child: const Text("Save Notifications"))
          ],
        ),
      ),
    );
  }

}
