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
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onSurface
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("${widget.amount} X ${widget.mealName}", style: style),
              const Spacer(flex: 1),
              Checkbox(
                  autofocus: true,
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  }),
            ],
          ),
        )
      ],
    );
  }
}
