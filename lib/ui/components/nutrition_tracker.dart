import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umte_project/state/nutrition_tracker_state.dart';
import 'package:umte_project/ui/components/source_ratio.dart';

/*

Icons provided by:
https://www.flaticon.com/free-icons/broccoli Broccoli icons created by Freepik
https://www.flaticon.com/free-icons/sugar-cube Sugar cube icons created by Freepik
https://www.flaticon.com/free-icons/carbohydrates Carbohydrates icons created by Good Ware
https://www.flaticon.com/free-icons/calories Calories icons created by Freepik

*/

class NutritionTracker extends StatefulWidget {
  const NutritionTracker({super.key});

  @override
  State<NutritionTracker> createState() => _NutritionTracker();

  final AssetImage fiberImage = const AssetImage('assets/images/broccoli.png');
  final AssetImage caloriesImage = const AssetImage('assets/images/calories.png');
  final AssetImage carbohydratesImage = const AssetImage('assets/images/carbohydrates.png');
  final AssetImage sugarCubeImage = const AssetImage('assets/images/sugar-cube.png');
}

class _NutritionTracker extends State<NutritionTracker> {

  @override
  Widget build(BuildContext context) {
    return Consumer<NutritionTrackerState>(builder: (context, nutritionState, child) {
      return Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Expanded(
                child: SourceRatio(
                    key: const Key('fiber'),
                    denum: nutritionState.fiberDenum,
                    value: nutritionState.fiber,
                    image: widget.fiberImage,
                    unitStr: "g",
                    isRealNum: true,
                    ),
              ),
              Expanded(
                child: SourceRatio(
                    key: const Key('carbs'),
                    denum: nutritionState.carbohydratesDenum,
                    value: nutritionState.carbohydrates,
                    image: widget.carbohydratesImage,
                    unitStr: "g",
                    isRealNum: true,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Expanded(
                child: SourceRatio(
                    key: const Key('sugars'),
                    denum: nutritionState.sugarsDenum,
                    value: nutritionState.sugars,
                    image: widget.sugarCubeImage,
                    unitStr: "g",
                    isRealNum: true,
                    ),
              ),
              Expanded(
                child: SourceRatio(
                    key: const Key('calories'),
                    denum: nutritionState.caloriesDenum,
                    value: nutritionState.calories,
                    image: widget.caloriesImage,
                    unitStr: "kcal",
                    isRealNum: false,
                    ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
