import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/data/enums/unit.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';
import 'package:umte_project/ui/components/meal/type_of_meal_dropdown_menu.dart';

class AddMealDialog extends StatefulWidget {
  AddMealDialog({super.key, required this.meal, required this.dateTime});

  final DateTime dateTime;
  final UsersMeal meal;
  final UserService userService = Get.find<UserService>();

  @override
  State<AddMealDialog> createState() => _AddMealDialog();
}

class _AddMealDialog extends State<AddMealDialog> {
  late DateTime dateTime;
  TypeOfMeal? typeOfMeal;
  int? amount;

  bool showProgress = false;

  @override
  void initState() {
    super.initState();

    dateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker(
            initialCalendarMode: DatePickerMode.day,
            initialDate: widget.dateTime,
            firstDate: DateTime(2020),
            onDateChanged: (date) {
              setState(() {
                dateTime = date;
              });
            },
            lastDate: DateTime(3000),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TypeOfMealDropDownMenu(onSelected: (value) {
                setState(() {
                  typeOfMeal = value;
                });
              }),
              AmountCounter(
                unit: Unit.pieces,
                onChanged: (value) {
                  setState(() {
                    amount = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          showProgress
              ? const Center(child: CircularProgressIndicator())
              : FilledButton(
                  child: const Text("Add to menu"),
                  onPressed: () => _onPressed(context),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    ThemeData theme = Theme.of(context);

    if (typeOfMeal == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: const Text("Please fill out the Type of Meal!"),
          backgroundColor: theme.colorScheme.error,
        ));
    }

    try {
      setState(() {
        showProgress = true;
      });

      await widget.userService.addUsersMealAsPlanned(widget.meal.id, dateTime, typeOfMeal!, amount);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Food was added to your menu!"),
          backgroundColor: Colors.green,
        ));

      Navigator.pop(context);

    } catch (err) {
      setState(() {
        showProgress = false;
      });
      print("An error occurred while adding a meal to the menu! $err");

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("An error occcurred while add a meal to the menu!"),
          backgroundColor: Colors.red,
        ));
    }
  }
}
