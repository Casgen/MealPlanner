import 'package:drift/drift.dart';

import '../data/enums/type_of_meal.dart';
import '../data/enums/unit.dart';
import 'database.dart';


class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 0, max: 1000)();
  RealColumn get calories => real().nullable()();
  RealColumn get fibre => real().nullable()();
  RealColumn get carbohydrates => real().nullable()();
  RealColumn get sugars => real().nullable()();
  RealColumn get fats => real().nullable()();
  TextColumn get unit => textEnum<Unit>()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 5, max: 50)();
  TextColumn get password => text().withLength(min: 128, max: 128)();
}

class UsersFavoriteFoods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get foodId => integer().references(Foods, #id)();
}

class UsersMeals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

class UsersConsumedMeals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get foodId => integer().references(Foods, #id)();
  IntColumn get usersMealId => integer().nullable().references(UsersMeals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get typeOfMeal => textEnum<TypeOfMeal>()();
  IntColumn get amount => integer()();
  BoolColumn get isChecked => boolean()();
}

class UsersMealsIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userMealId => integer().references(UsersMeals, #id)();
  IntColumn get foodId => integer().references(Foods, #id)();
  IntColumn get amount => integer()();
}

class FoodIngredient {
  FoodIngredient(this.ingredient, this.food);

  final UsersMealsIngredient ingredient;
  final Food food;
}
