
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umte_project/data/enums/response_enum.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/dao/user_dao.dart';
import 'package:umte_project/database/database.dart';

import '../database/dao/foods_dao.dart';

class UserService {

  final UsersDao _usersDao = Get.find<UMTEDatabase>().usersDao;
  final FoodsDao _foodsDao = Get.find<UMTEDatabase>().foodsDao;


  Future<void> registerUser(String username, String password) async {
    await _usersDao.addUser(username, _hashString(password));
  }

  Future<ResponseEnum> loginUser(String username, String password) async {
    User? user = await _usersDao.getUserByUsername(username);

    if (user == null) {
      return ResponseEnum.userNotFound;
    }

    if (user.password != _hashString(password)) {
      return ResponseEnum.passwordNotMatched;
    }

    SharedPreferences dataStore = await SharedPreferences.getInstance();
    dataStore.setInt("userId", user.id);

    return ResponseEnum.success;
  }

  Future<void> addFoodToFavorites(int userId, int foodId) async {
    await _usersDao.saveFavoriteFood(userId, foodId);
  }

  Future<void> addLoggedInUsersFoodToFavorites(int foodId) async {
    int userId = await _obtainUserId();
    await _usersDao.saveFavoriteFood(userId, foodId);
  }

  Future<void> removeFoodFromFavorites(int userId, int foodId) async {
    return await _usersDao.removeFavoriteFood(userId, foodId);
  }

  Future<void> removeLoggedInUsersFoodFromFavorites(int foodId) async {
    int userId = await _obtainUserId();
    return await _usersDao.removeFavoriteFood(userId, foodId);
  }

  Future<bool> isLoggedInUsersFoodFavorite(int foodId) async {
      int userId = await _obtainUserId();
      return (await _usersDao.findFavoriteFoodByUserIdAndFoodId(userId, foodId)) != null;
  }

  Future<List<Food>> getUsersFavoriteFoods(int userId) async {
    List<UsersFavoriteFood> usersFavoriteFoods = await _usersDao.findAllFavoriteFoodsByUserId(userId);

    List<int> foodIds = usersFavoriteFoods.map((e) => e.foodId).toList();

    return await _foodsDao.findAllByFoodIds(foodIds);
  }

  Future<List<UsersPlannedMeal>> getLoggedInUsersPlannedMealsByWeekday(DateTime dateTime, TypeOfMeal typeOfMeal) async {
    int userId = await _obtainUserId();
    return await _usersDao.findAllUsersPlannedMealsByIdAndDateTimeAndWeekday(userId, dateTime, typeOfMeal);
  }

  Future<List<UsersPlannedMeal>> getLoggedInUsersPlannedMeals(DateTime dateTime) async {
    int userId = await _obtainUserId();
    return await _usersDao.findAllUsersPlannedMealsByIdAndDateTime(userId, dateTime);
  }

  Future<List<Food>> getLoggedInUsersPlannedFoods(DateTime dateTime, TypeOfMeal typeOfMeal) async {
    int userId = await _obtainUserId();
    List<UsersPlannedMeal> usersPlannedMeals = await _usersDao.findAllUsersPlannedMealsByIdAndDateTimeAndWeekday(userId, dateTime, typeOfMeal);
    
    List<int> foodIds = usersPlannedMeals
        .map((e) => e.foodId)
        .whereType<int>()
        .toList();
    
    return await _foodsDao.findAllByFoodIds(foodIds);
  }

  Future<List<UsersMeal>> getAllUsersMealsById(List<int> usersMealIds) {
    return _usersDao.findAllUsersMealsByIds(usersMealIds);
  }
  
  Future<UsersMeal?> getUsersMealById(int usersMealId) {
    return _usersDao.findUsersMealById(usersMealId);
  }
  

  Future<List<UsersMeal>> getLoggedInUsersOwnPlannedMeals(DateTime dateTime, TypeOfMeal typeOfMeal) async {
    List<UsersPlannedMeal> usersPlannedMeals = await getLoggedInUsersPlannedMealsByWeekday(dateTime, typeOfMeal);

    List<int> usersMealIds = usersPlannedMeals
        .map((e) => e.usersMealId)
        .whereType<int>()
        .toList();

    return await _usersDao.findAllUsersMealsByIds(usersMealIds);
  }

  Future<void> addFoodAsPlanned(int foodId, DateTime dateTime, TypeOfMeal typeOfMeal, int? amount) async {
    int userId = await _obtainUserId();
    amount ??= 1;

    _usersDao.saveUsersPlannedFoodToADay(userId, foodId, dateTime, typeOfMeal, amount);
  }

  Future<void> addUsersMealAsPlanned(int foodId, DateTime dateTime, TypeOfMeal typeOfMeal, int? amount) async {
    int userId = await _obtainUserId();
    amount ??= 1;

    _usersDao.saveUsersPlannedMealToADay(userId, foodId, dateTime, typeOfMeal, amount);
  }

  Future<int> _obtainUserId() async {
    int? userId = (await SharedPreferences.getInstance()).getInt("userId");
    assert(userId != null);
    return userId!;
  }

  String _hashString(String text) {
    List<int> bytes = utf8.encode(text);
    Digest hash = sha512.convert(bytes);

    return hash.toString();
  }



}