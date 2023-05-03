import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'users_meals_ingredients_dao.g.dart';

@DriftAccessor(tables: [UsersMealsIngredients])
class UsersMealsIngredientsDao extends DatabaseAccessor<UMTEDatabase>
    with _$UsersMealsIngredientsDaoMixin {
  UsersMealsIngredientsDao(UMTEDatabase db) : super(db);

  Future<List<UsersMealsIngredient>> findAllIngredientsByUsersMealId(
      int usersMealId) async {
    return (select(usersMealsIngredients)
          ..where((tbl) => tbl.userMealId.equals(usersMealId)))
        .get();
  }

  Future<void> saveUsersMealsIngredient(UsersMeal usersMeal, Food food) {
    return into(usersMealsIngredients).insert(UsersMealsIngredientsCompanion(
        foodId: Value(food.id),
        userMealId: Value(usersMeal.id),
        amount: const Value(0)));
  }

  Future<void> insertUsersMealsIngredients(
      UsersMeal usersMeal, List<Food> foodsList) async {
    return batch((batch) {
      List<UsersMealsIngredientsCompanion> inserts = foodsList
          .map((food) => UsersMealsIngredientsCompanion.insert(
              userMealId: usersMeal.id, foodId: food.id, amount: 1))
          .toList();

      batch.insertAll(usersMealsIngredients, inserts);
    });
  }

  Future<void> updateUsersMealsIngredientAmountById(
      int ingredientId, int amount) {
    return (update(usersMealsIngredients)
          ..where((tbl) => tbl.id.equals(ingredientId)))
        .write(UsersMealsIngredientsCompanion(amount: Value(amount)));
  }
}
