import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/services/user_service.dart';

class NutritionTrackerState extends ChangeNotifier {
  List<Food> consumedFoods;
  List<UsersMeal> consumedMeals;

  Map<String, int> mapAmounts;

  UserService userService = Get.find<UserService>();

  double fiber = 0.0;
  double carbohydrates = 0.0;
  double sugars = 0.0;
  double calories = 0.0;
  double fats = 0.0;

  double fiberDenum = 20.0;
  double carbohydratesDenum = 80.0;
  double sugarsDenum = 30.0;
  double caloriesDenum = 2200.0;

  NutritionTrackerState()
      : consumedFoods = [],
        consumedMeals = [],
        mapAmounts = {} ;

  void addConsumedFood(Food food, int amount) {
    consumedFoods.add(food);
    mapAmounts['F-${food.id}'] = amount;
    _updateNutritions();

    notifyListeners();
  }

  void removeConsumedFood(Food food) {
    consumedFoods.remove(food);
    mapAmounts.remove('F-${food.id}');
    _updateNutritions();

    notifyListeners();
  }

  void addConsumedMeal(UsersMeal usersMeal, int amount) {
    consumedMeals.add(usersMeal);
    mapAmounts['U-${usersMeal.id}'] = amount;
    _updateNutritions();

    notifyListeners();
  }

  void removeConsumedMeal(UsersMeal usersMeal) {
    consumedMeals.remove(usersMeal);
    mapAmounts.remove('U-${usersMeal.id}');
    _updateNutritions();

    notifyListeners();
  }

  void clearArrays() {
    consumedFoods.clear();
    consumedMeals.clear();
    mapAmounts.clear();
    _resetValues();

    notifyListeners();
  }


  void _updateNutritions() {

    if (consumedFoods.isEmpty && consumedMeals.isEmpty) {
      return _resetValues();
    }

    List<double> fibreArray = consumedFoods.map((food) => (food.fibre ?? 0.0) * (mapAmounts['F-${food.id}'] ?? 0)).toList();
    List<double> carbohydratesArray = consumedFoods.map((food) => (food.carbohydrates ?? 0.0) * (mapAmounts['F-${food.id}'] ?? 0)).toList();
    List<double> sugarsArray = consumedFoods.map((food) => (food.sugars ?? 0.0) * (mapAmounts['F-${food.id}'] ?? 0)).toList();
    List<double> fatsArray = consumedFoods.map((food) => (food.fats ?? 0.0) * (mapAmounts['F-${food.id}'] ?? 0)).toList();
    List<double> caloriesArray = consumedFoods.map((food) => (food.calories ?? 0.0) * (mapAmounts['F-${food.id}'] ?? 0)).toList();

    fibreArray.addAll(consumedMeals.map((meal) => (meal.fibre ?? 0.0) * (mapAmounts['U-${meal.id}'] ?? 0)).toList());
    carbohydratesArray.addAll(consumedMeals.map((meal) => (meal.carbohydrates ?? 0.0) * (mapAmounts['U-${meal.id}'] ?? 0)).toList());
    sugarsArray.addAll(consumedMeals.map((meal) => (meal.sugars ?? 0.0) * (mapAmounts['U-${meal.id}'] ?? 0)).toList());
    fatsArray.addAll(consumedMeals.map((meal) => (meal.fats ?? 0.0) * (mapAmounts['U-${meal.id}'] ?? 0)).toList());
    caloriesArray.addAll(consumedMeals.map((meal) => (meal.calories ?? 0.0) * (mapAmounts['U-${meal.id}'] ?? 0)).toList());

    fiber = fibreArray.reduce((value, element) => value + element);
    carbohydrates = carbohydratesArray.reduce((value, element) => value + element);
    sugars = sugarsArray.reduce((value, element) => value + element);
    fats = fatsArray.reduce((value, element) => value + element);
    calories = caloriesArray.reduce((value, element) => value + element);
  }

  void _resetValues() {
    fiber = 0.0;
    carbohydrates = 0.0;
    sugars = 0.0;
    fats = 0.0;
    calories = 0.0;
  }

}
