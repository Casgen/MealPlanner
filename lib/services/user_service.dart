import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umte_project/data/enums/response_enum.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/dao/user_dao.dart';
import 'package:umte_project/database/dao/users_meals_ingredients_dao.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

import '../database/dao/foods_dao.dart';

class UserService {
  final UsersDao _usersDao = Get.find<UMTEDatabase>().usersDao;
  final FoodsDao _foodsDao = Get.find<UMTEDatabase>().foodsDao;
  final UsersMealsIngredientsDao _usersMealsIngredientsDao =
      Get.find<UMTEDatabase>().usersMealsIngredientsDao;

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
    return _usersDao.saveFavoriteFood(userId, foodId);
  }

  Future<void> addLoggedInUsersFoodToFavorites(int foodId) async {
    int userId = await _obtainUserId();
    return _usersDao.saveFavoriteFood(userId, foodId);
  }

  Future<void> updateUsersMealIngredient(UsersMealsIngredient ingredient, int amount) async {
    await _usersMealsIngredientsDao.updateUsersMealsIngredientAmountById(ingredient.id, amount);
    _updateUsersMealNutritionsById(ingredient.userMealId);
  }

  Future<void> addFoodIngredientsToUsersMeal(UsersMeal usersMeal, List<Food> foods) async {
    await _usersMealsIngredientsDao.insertUsersMealsIngredients(usersMeal, foods);
    return _updateUsersMealNutritionsById(usersMeal.id);
  }

  Future<void> _updateUsersMealNutritionsById(int usersMealId) async {

    List<UsersMealsIngredient> ingredients = await _usersMealsIngredientsDao.findAllIngredientsByUsersMealId(usersMealId);
    List<int> foodIds = ingredients.map((ingredient) => ingredient.foodId).toList();
    
    List<Food> foods = await _foodsDao.findAllByFoodIds(foodIds);

    List<double> fibreArray = foods.map((food) => food.fibre ?? 0.0).toList(); 
    List<double> carbohydratesArray = foods.map((food) => food.carbohydrates ?? 0.0).toList(); 
    List<double> sugarsArray = foods.map((food) => food.sugars ?? 0.0).toList(); 
    List<double> fatsArray = foods.map((food) => food.fats ?? 0.0).toList(); 
    List<double> caloriesArray = foods.map((food) => food.calories ?? 0.0).toList(); 

    double fibreSum = fibreArray.reduce((value, element) => value + element);
    double carbohydratesSum = carbohydratesArray.reduce((value, element) => value + element);
    double sugarsSum = sugarsArray.reduce((value, element) => value + element);
    double fatsSum = fatsArray.reduce((value, element) => value + element);
    double caloriesSum = caloriesArray.reduce((value, element) => value + element);
    
    _usersDao.updateUsersMealNutrition(usersMealId, carbohydratesSum, fibreSum, sugarsSum, caloriesSum, fatsSum);
  }

  Future<void> createNewUsersMeal(String name) async {
    int userId = await _obtainUserId();
    
    return _usersDao.saveUsersMeal(name, userId);
  } 

  Future<void> removeFoodFromFavorites(int userId, int foodId) async {
    return _usersDao.removeFavoriteFood(userId, foodId);
  }

  Future<void> removeLoggedInUsersFoodFromFavorites(int foodId) async {
    int userId = await _obtainUserId();
    return _usersDao.removeFavoriteFood(userId, foodId);
  }

  Future<bool> isLoggedInUsersFoodFavorite(int foodId) async {
    int userId = await _obtainUserId();

    UsersFavoriteFood? favoriteFood = await _usersDao.findFavoriteFoodByUserIdAndFoodId(userId, foodId);
    return favoriteFood != null;
  }

  Future<List<Food>> getUsersFavoriteFoods(int userId) async {
    List<UsersFavoriteFood> usersFavoriteFoods =
        await _usersDao.findAllFavoriteFoodsByUserId(userId);

    List<int> foodIds = usersFavoriteFoods.map((e) => e.foodId).toList();

    return await _foodsDao.findAllByFoodIds(foodIds);
  }

  Future<List<UsersPlannedMeal>> getLoggedInUsersPlannedMealsByWeekday(
      DateTime dateTime, TypeOfMeal typeOfMeal) async {
    int userId = await _obtainUserId();
    return await _usersDao.findAllUsersPlannedMealsByIdAndDateTimeAndWeekday(
        userId, dateTime, typeOfMeal);
  }

  Future<List<UsersPlannedMeal>> getLoggedInUsersPlannedMeals(
      DateTime dateTime) async {
    int userId = await _obtainUserId();
    return await _usersDao.findAllUsersPlannedMealsByIdAndDateTime(
        userId, dateTime);
  }

  Future<List<Food>> getLoggedInUsersPlannedFoods(
      DateTime dateTime, TypeOfMeal typeOfMeal) async {
    int userId = await _obtainUserId();
    List<UsersPlannedMeal> usersPlannedMeals =
        await _usersDao.findAllUsersPlannedMealsByIdAndDateTimeAndWeekday(
            userId, dateTime, typeOfMeal);

    List<int> foodIds =
        usersPlannedMeals.map((e) => e.foodId).whereType<int>().toList();

    return await _foodsDao.findAllByFoodIds(foodIds);
  }

  Future<List<UsersMeal>> getAllUsersMealsById(List<int> usersMealIds) {
    return _usersDao.findAllUsersMealsByIds(usersMealIds);
  }

  Future<UsersMeal?> getUsersMealById(int usersMealId) {
    return _usersDao.findUsersMealById(usersMealId);
  }

  Future<List<UsersMeal>> getLoggedInUsersOwnPlannedMeals(
      DateTime dateTime, TypeOfMeal typeOfMeal) async {
    List<UsersPlannedMeal> usersPlannedMeals =
        await getLoggedInUsersPlannedMealsByWeekday(dateTime, typeOfMeal);

    List<int> usersMealIds =
        usersPlannedMeals.map((e) => e.usersMealId).whereType<int>().toList();

    return await _usersDao.findAllUsersMealsByIds(usersMealIds);
  }

  Future<List<UsersMeal>> getLoggedInUsersMeals() async {
    int userId = await _obtainUserId();

    return await _usersDao.findAllUsersMealsByUserId(userId);
  }

  Future<void> addFoodAsPlanned(
      int foodId, DateTime dateTime, TypeOfMeal typeOfMeal, int? amount) async {
    int userId = await _obtainUserId();
    amount ??= 1;

    _usersDao.saveUsersPlannedFoodToADay(
        userId, foodId, dateTime, typeOfMeal, amount);
  }

  Future<void> addUsersMealAsPlanned(
      int foodId, DateTime dateTime, TypeOfMeal typeOfMeal, int? amount) async {
    int userId = await _obtainUserId();
    amount ??= 1;

    _usersDao.saveUsersPlannedMealToADay(
        userId, foodId, dateTime, typeOfMeal, amount);
  }

  Future<List<Food>> getFoodsFromUsersMeal(int usersMealId) async {
    List<UsersMealsIngredient> usersMealsIngredients =
        await _usersMealsIngredientsDao
            .findAllIngredientsByUsersMealId(usersMealId);

    List<int> foodIds =
        usersMealsIngredients.map((ingredient) => ingredient.foodId).toList();

    return _foodsDao.findAllByFoodIds(foodIds);
  }

  Future<List<UsersMealsIngredient>> getIngredientsFromUsersMeal(int usersMealId) async {
    return _usersMealsIngredientsDao.findAllIngredientsByUsersMealId(usersMealId);
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
