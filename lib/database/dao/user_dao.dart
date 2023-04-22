import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, UsersFavoriteFoods])
class UsersDao extends DatabaseAccessor<UMTEDatabase> with _$UsersDaoMixin {

  UsersDao(UMTEDatabase db) : super(db);

  Future<void> addUser(String username, String password) async {
    await into(users).insert(
        UsersCompanion(
            username: Value(username),
            password: Value(password)
        )
    );
  }

  Future<User?> getUserByUsername(String username) async {
    return await (select(users)..where((tbl) => tbl.username.equals(username)))
        .getSingleOrNull();
  }

  Future<void> insertFavoriteFood(int userId, int foodId) async {
    await into(usersFavoriteFoods).insert(
      UsersFavoriteFoodsCompanion(
        userId: Value(userId),
        foodId: Value(foodId),
      )
    );
  }

  Future<void> removeFavoriteFood(int userId, int foodId) async {
    await (delete(usersFavoriteFoods)
      ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .go();
  }

  Future<UsersFavoriteFood?> findFavoriteFoodByUserIdAndFoodId(int userId, int foodId) async {
    return await (select(usersFavoriteFoods)
        ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .getSingleOrNull();
  }

  Stream<UsersFavoriteFood?> watchFavoriteFoodByUserIdAndFoodId(int userId, int foodId) {
    return (select(usersFavoriteFoods)
      ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .watchSingleOrNull();
  }

  Future<List<UsersFavoriteFood>> findAllFavoriteFoodsByUserId(int userId) async {
    return await (select(usersFavoriteFoods)
      ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

}