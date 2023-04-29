
import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'users_meals_ingredients_dao.g.dart';

@DriftAccessor(tables: [UsersMealsIngredients])
class UsersMealsIngredientsDao extends DatabaseAccessor<UMTEDatabase> with _$UsersMealsIngredientsDaoMixin {

  UsersMealsIngredientsDao(UMTEDatabase db) : super(db);


  Future<List<UsersMealsIngredient>> findAllIngredientsByUsersMealId(int usersMealId) async {
      return (select(usersMealsIngredients)..where((tbl) => tbl.userMealId.equals(usersMealId))).get();
  }

}
