import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:umte_project/database/database.dart';

import 'amount_counter.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  int amount = 100;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Nutrition", style: theme.textTheme.titleLarge),
                const Spacer(),
                AmountCounter(
                  unit: widget.food.unit,
                  initialValue: amount,
                  onChanged: (value) {
                    setState(() {
                      amount = value;
                    });
                  },
                ),
              ],
            ),
            NutritionRow(
                unit: "kcal",
                nutritionText: "Calories",
                amount: widget.food.calories != null
                    ? amount * widget.food.calories!
                    : 0.0),
            NutritionRow(
                nutritionText: "Fibre",
                unit: "g",
                amount: widget.food.fibre != null
                    ? amount * widget.food.fibre!
                    : 0.0),
            NutritionRow(
              nutritionText: "Carbohydrates",
              unit: "g",
              amount: widget.food.carbohydrates != null
                  ? amount * widget.food.carbohydrates!
                  : 0.0,
            ),
            NutritionRow(
              unit: "g",
              nutritionText: "Of which sugars",
              amount: widget.food.sugars != null
                  ? amount * widget.food.sugars!
                  : 0.0,
              leftOffset: 15,
            ),
            NutritionRow(
                unit: "g",
                nutritionText: "Fats",
                amount: widget.food.fats != null ?
                amount * widget.food.fats! : 0.0),
          ],
        ),
      ),
    );
  }
}

class NutritionRow extends StatelessWidget {
  const NutritionRow(
      {super.key,
      required this.nutritionText,
      required this.amount,
        required this.unit,
      this.leftOffset = 0.0});

  final String nutritionText;
  final double? amount;
  final double leftOffset;
  final String unit;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300);
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.colorScheme.primary))),
      child: Row(
        children: [
          SizedBox(
            width: leftOffset,
          ),
          Text(
            nutritionText,
            style: style,
          ),
          const Spacer(),
          Text(
            amount != null ? format('{:.2f} $unit', amount!) : '-',
            style: style,
          )
        ],
      ),
    );
  }
}
