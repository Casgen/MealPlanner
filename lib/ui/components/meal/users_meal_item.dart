import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/state/nutrition_tracker_state.dart';

class UsersMealItem extends StatefulWidget {
  const UsersMealItem({
    super.key,
    required this.usersMeal,
    required this.amount,
    required this.isChecked,
  });

  final UsersMeal usersMeal;
  final int amount;
  final bool isChecked;

  @override
  State<StatefulWidget> createState() => _UsersMealItem();
}

class _UsersMealItem extends State<UsersMealItem> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    if (widget.isChecked) _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!
        .copyWith(color: theme.colorScheme.onSurface);

    return Consumer<NutritionTrackerState>(
        builder: (builder, nutritionState, child) {
      if (widget.isChecked) nutritionState.addConsumedMeal(widget.usersMeal, widget.amount);
      return Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          Text(widget.amount.toString(), style: style),
          const Icon(Icons.close_rounded, size: 15),
          const Spacer(flex: 1),
          Text(widget.usersMeal.name, style: style),
          Checkbox(
              autofocus: true,
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue!;
                });

                if (newValue!) {
                  return nutritionState.addConsumedMeal(widget.usersMeal, widget.amount);
                }
                
                return nutritionState.removeConsumedMeal(widget.usersMeal);
              }),
        ],
      );
    });
  }
}
