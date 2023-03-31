import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umte_project/database/database.dart';

class MealItem extends StatefulWidget {

  const MealItem({super.key, required this.mealName, required this.amount});

  final String mealName;
  final int amount;

  @override
  State<MealItem> createState() => _MealItem();

}

class _MealItem extends State<MealItem> {

  bool? _isChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("${widget.amount} X ${widget.mealName}"),
                Checkbox(value: false, onChanged: (bool? newValue) {
                  setState(() {
                    _isChecked = newValue;
                  });
                }),
              ],
            ),
        )
      ],
    );
  }

}