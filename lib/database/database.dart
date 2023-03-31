import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';

part "database.g.dart";


class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 0, max: 1000)();
  RealColumn get calories => real()();
  RealColumn get fibre => real()();
  RealColumn get carbohydrates => real()();
  RealColumn get sugars => real()();
  RealColumn get fats => real()();
  TextColumn get units => text().withLength(min: 1, max: 30)();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 5, max: 50)();
  TextColumn get email => text().unique().withLength(min: 5, max: 70)();
  TextColumn get password => text().withLength(min: 12, max: 30)();
}

class UsersMeals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

class UsersConsumedMeals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  IntColumn get foodId => integer().nullable()();
  IntColumn get usersMealId => integer().nullable()();
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

@DriftDatabase(tables: [Foods, Users, UsersMeals, UsersMealsIngredients, UsersConsumedMeals])
class UMTEDatabase extends _$UMTEDatabase {

  UMTEDatabase() : super(_openConnection());
  UMTEDatabase.withQueryExecutor(QueryExecutor e) : super(e);

  Future<Food> getFoodByName(String name) {
    return (select(foods)
      ..where((f) => f.name.equals(name))).getSingle();
  }

  Future<User> getUserById(int userId) {
    return (select(users)
      ..where((u) => u.id.equals(userId))).getSingle();
  }

  getUsersMealsIngredients(int usersMealId) async {
    return await (select(usersMealsIngredients)
        .join([innerJoin(foods, foods.id.equalsExp(usersMealsIngredients.foodId))])
    ..where(usersMealsIngredients.userMealId.equals(usersMealId))).get();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}