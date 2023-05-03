import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';

class IngredientItem extends StatefulWidget {
  IngredientItem({
    super.key,
    required this.ingredient,
    required this.food,
  });

  final Food food;
  final UsersMealsIngredient ingredient;
  final UserService userService = Get.find<UserService>();

  @override
  State<IngredientItem> createState() => _IngredientItem();
}

class _IngredientItem extends State<IngredientItem> {
  
  bool _isAmountDifferent = false;
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
        IconButton(
          onPressed: _onRemove,
          icon: const Icon(Icons.delete_rounded)
        ),
        Text(widget.food.name),
        const Spacer(),
        if (_isAmountDifferent)...[
          IconButton(
              onPressed: _onSave,
              icon: const Icon(Icons.save)
          ),
        ],
        AmountCounter(
          unit: widget.food.unit,
          initialValue: widget.ingredient.amount,
          onChanged: (value) {
            setState(() {
              _amount = value;
            });

            if (widget.ingredient.amount != value) {
              setState(() {
                _isAmountDifferent = true;
              });
              return;
            }
            return setState(() {
              _isAmountDifferent = false;
            });
          },
        )
      ],
    );
  }

  void _onRemove() async {

  }

  void _onSave() async {
    try {
      await widget.userService.updateUsersMealIngredient(widget.ingredient, _amount);

      setState(() {
        _isAmountDifferent = false;
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Saved!"),
          backgroundColor: Colors.green,
        ));


    } catch (err) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Failed to save the amount!"),
          backgroundColor: Colors.red,
        ));
    }
  }
  
}
