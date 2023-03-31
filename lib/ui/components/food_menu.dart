
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umte_project/ui/components/meal/meal_widget.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MealWidget()
      ],
    );
  }

}