import 'package:umte_project/database/database.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class AppState extends ChangeNotifier {
  List<Food> _foodIngredients;
  List<Food> get foodIngredients => _foodIngredients;

  bool _loggedIn;
  bool get loggedIn => _loggedIn;

  AppState()
      : _foodIngredients = [],
        _loggedIn = false;

  void addFoodIngredient(Food food) {
    _foodIngredients.add(food);
    notifyListeners();
  }

  void initFoodIngredientsList(List<Food> newList) {
    _foodIngredients = newList;
    notifyListeners();
  }

  void setLoggedIn(bool isLoggedIn) {
    _loggedIn = isLoggedIn;
  }

  void removeFoodIngredient(Food food) {
    _foodIngredients.remove(food);
    notifyListeners();
  }

  void clearFoodIngredients() {
    _foodIngredients.clear();
    notifyListeners();
  }
}
