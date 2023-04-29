import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/ui/components/food/amount_counter.dart';

class IngredientItem extends StatefulWidget {
  const IngredientItem({
    super.key,
    required this.ingredient,
    required this.food,
  });

  final Food food;
  final UsersMealsIngredient ingredient;

  @override
  State<IngredientItem> createState() => _IngredientItem();
}

class _IngredientItem extends State<IngredientItem> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: _onRemove, icon: const Icon(Icons.delete_rounded)),
        Text(widget.food.name),
        AmountCounter(
          unit: widget.food.unit,
          initialValue: widget.ingredient.amount,
        )
      ],
    );
  }

  void _onRemove() {}
  
}
