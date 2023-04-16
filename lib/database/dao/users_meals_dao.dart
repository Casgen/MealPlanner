
import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'users_meals_dao.g.dart';

@DriftAccessor(tables: [UsersMeals])
class UsersMealsDao extends DatabaseAccessor<UMTEDatabase> with _$UsersMealsDaoMixin {

  UsersMealsDao(UMTEDatabase db) : super(db);

  Future<List<UsersMeal>> getUsersMeals(int userId) {
    return (select(usersMeals)..where((tbl) => tbl.userId.equals(userId))).get();
  }


}