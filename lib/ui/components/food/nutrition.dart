import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:umte_project/database/database.dart';

import 'amount_counter.dart';

class Nutrition extends StatefulWidget {
  Nutrition({
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
                nutritionText: "Calories", amount: amount * widget.food.calories!),
            NutritionRow(nutritionText: "Fibre", amount: amount * widget.food.fibre!),
            NutritionRow(
              nutritionText: "Carbohydrates",
              amount: amount * widget.food.carbohydrates!,
            ),
            NutritionRow(
              nutritionText: "Of which sugars",
              amount: amount * widget.food.sugars!,
              leftOffset: 15,
            ),
            NutritionRow(nutritionText: "Fats", amount: amount * widget.food.fats!),
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
        this.leftOffset = 0.0});

  final String nutritionText;
  final double? amount;
  final double leftOffset;

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
            amount != null ? format('{:.2f} g', amount!) : '-',
            style: style,
          )
        ],
      ),
    );
  }
}
