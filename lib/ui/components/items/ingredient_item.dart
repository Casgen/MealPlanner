import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';
import 'package:umte_project/ui/dialogs/add_meal_dialog.dart';

class IngredientItem extends StatefulWidget {
  IngredientItem({
    super.key,
    required this.ingredient,
    required this.food,
    this.onRemove,
  });

  final Food food;
  final UsersMealsIngredient ingredient;
  final UserService userService = Get.find<UserService>();
  final void Function(UsersMealsIngredient ingredient)? onRemove;

  @override
  State<IngredientItem> createState() => _IngredientItem();
}

class _IngredientItem extends State<IngredientItem> {

  int _amount = 0;

  @override
  void initState() {
    super.initState();
    _amount = widget.ingredient.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.food.name),
        const Spacer(),
        AmountCounter(
          unit: widget.food.unit,
          initialValue: widget.ingredient.amount,
          onChanged: _onAmountChanged,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        PopupMenuButton(
            onSelected: _onSelected,
            itemBuilder: (context) =>
                IngredientAction.values.map((action) {
                  return PopupMenuItem<IngredientAction>(
                    value: action,
                    child: Text(action.getString()),
                  );
                }).toList()
        )
      ],
    );
  }

  void _onSelected(IngredientAction action) {
    switch (action) {
      case IngredientAction.delete:
        return _onRemove();
    }
  }

  void _onRemove() async {
    try {
      await widget.userService.removeUsersMealIngredient(widget.ingredient);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Ingredient removed."),
        ));

      if (widget.onRemove != null) {
        widget.onRemove!(widget.ingredient);
      }
    } catch (err) {
      print(err);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("An error occurred while deleting an ingredient!"),
          backgroundColor: Colors.red,
        ));
    }
  }

  void _onFieldSubmitted(int value) async {
    try {
      await widget.userService.updateUsersMealIngredient(widget.ingredient, value);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Saved!"),
        ));

    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Failed to save the amount!"),
          backgroundColor: Colors.red,
        ));
    }
  }

  void _onAmountChanged(int value) {
    setState(() {
      _amount = value;
    });
  }

}

enum IngredientAction {
  delete;

  String getString() {
    switch (this) {
      case IngredientAction.delete:
        return "Delete";
      default:
        return "NOT_RECOGNIZED";
    }
  }
}
