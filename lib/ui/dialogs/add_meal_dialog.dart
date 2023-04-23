import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';
import 'package:umte_project/ui/components/meal/type_of_meal_dropdown_menu.dart';

class AddMealDialog extends StatefulWidget {
  AddMealDialog({super.key, required this.food, required this.dateTime});

  final DateTime dateTime;
  final Food food;
  final UserService userService = Get.find<UserService>();

  @override
  State<StatefulWidget> createState() => _AddMealDialog();
}

class _AddMealDialog extends State<AddMealDialog> {
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();

    dateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
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
          TypeOfMealDropDownMenu(onSelected: (typeOfMeal) {}),
          AmountCounter(unit: widget.food.unit)
        ],
      ),
    );
  }
}
