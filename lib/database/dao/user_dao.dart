import 'package:drift/drift.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, UsersFavoriteFoods, UsersPlannedMeals, UsersMeals, UsersMealsIngredients])
class UsersDao extends DatabaseAccessor<UMTEDatabase> with _$UsersDaoMixin {

  UsersDao(UMTEDatabase db) : super(db);

  Future<void> addUser(String username, String password) {
    return into(users).insert(
        UsersCompanion(
            username: Value(username),
            password: Value(password)
        )
    );
  }

  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((tbl) => tbl.username.equals(username)))
        .getSingleOrNull();
  }

  Future<void> saveFavoriteFood(int userId, int foodId) {
    return into(usersFavoriteFoods).insert(
      UsersFavoriteFoodsCompanion(
        userId: Value(userId),
        foodId: Value(foodId),
      )
    );
  }

  Future<void> removeFavoriteFood(int userId, int foodId) {
    return (delete(usersFavoriteFoods)
      ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .go();
  }

  Future<UsersPlannedMeal?> findUsersPlannedMealById(int usersMealId) {
    return (select(usersPlannedMeals)..where((tbl) => tbl.id.equals(usersMealId))).getSingleOrNull();
  }

  Future<List<UsersPlannedMeal>> findAllUsersPlannedMealsByIdAndDateTimeAndWeekday(int userId, DateTime dateTime, TypeOfMeal typeOfMeal) {
    return (select(usersPlannedMeals)..where((tbl) =>
      tbl.userId.equals(userId) &
      tbl.date.day.equals(dateTime.day) &
      tbl.date.month.equals(dateTime.month) &
      tbl.date.year.equals(dateTime.year) &
      tbl.typeOfMeal.equals(typeOfMeal.toString())
    )).get();
  }

  Future<List<UsersPlannedMeal>> findAllUsersPlannedMealsByIdAndDateTime(int userId, DateTime dateTime) {
    return (select(usersPlannedMeals)..where((tbl) =>
      tbl.userId.equals(userId) &
      tbl.date.day.equals(dateTime.day) &
      tbl.date.month.equals(dateTime.month) &
      tbl.date.year.equals(dateTime.year)
    )).get();
  }

  Future<UsersFavoriteFood?> findFavoriteFoodByUserIdAndFoodId(int userId, int foodId) {
    return (select(usersFavoriteFoods)
        ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .getSingleOrNull();
  }

  Stream<UsersFavoriteFood?> watchFavoriteFoodByUserIdAndFoodId(int userId, int foodId) {
    return (select(usersFavoriteFoods)
      ..where((tbl) => tbl.foodId.equals(foodId) & tbl.userId.equals(userId)))
        .watchSingleOrNull();
  }

  Future<List<UsersFavoriteFood>> findAllFavoriteFoodsByUserId(int userId) {
    return (select(usersFavoriteFoods)
      ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<List<UsersMeal>> findAllUsersMealsByIds(List<int> usersMealIds) {
    return (select(usersMeals)..where((tbl) => tbl.id.isIn(usersMealIds))).get();
  }
  
  Future<UsersMeal?> findUsersMealById(int usersMealId) {
    return (select(usersMeals)..where((tbl) => tbl.id.equals(usersMealId))).getSingleOrNull();
  }

  Future<void> saveUsersPlannedFoodToADay(int userId, int foodId, DateTime dateTime, TypeOfMeal typeOfMeal, int amount) {
    return into(usersPlannedMeals).insert(
        UsersPlannedMealsCompanion(
          userId: Value(userId),
          amount: Value(amount),
          date: Value(dateTime),
          foodId: Value(foodId),
          isChecked: const Value(false),
          typeOfMeal: Value(typeOfMeal)
      )
    );
  }

  Future<void> saveUsersPlannedMealToADay(int userId, int usersMealId, DateTime dateTime, TypeOfMeal typeOfMeal, int amount) {
    return into(usersPlannedMeals).insert(
        UsersPlannedMealsCompanion(
            userId: Value(userId),
            amount: Value(amount),
            date: Value(dateTime),
            usersMealId: Value(usersMealId),
            isChecked: const Value(false),
            typeOfMeal: Value(typeOfMeal)
        )
    );
  }


  Future<bool> updateUsersPlannedMeal(UsersPlannedMeal usersPlannedMeal) {
    return update(usersPlannedMeals).replace(usersPlannedMeal);
  }

}