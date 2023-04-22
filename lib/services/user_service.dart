
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umte_project/data/enums/response_enum.dart';
import 'package:umte_project/database/dao/user_dao.dart';
import 'package:umte_project/database/database.dart';

import '../database/dao/foods_dao.dart';

class UserService {

  final UsersDao _usersDao = Get.find<UMTEDatabase>().usersDao;
  final FoodsDao _foodsDao = Get.find<UMTEDatabase>().foodsDao;


  String _hashString(String text) {
    List<int> bytes = utf8.encode(text);
    Digest hash = sha512.convert(bytes);

    return hash.toString();
  }

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
    await _usersDao.insertFavoriteFood(userId, foodId);
  }

  Future<void> addLoggedInUsersFoodToFavorites(int foodId) async {
    int? userId = (await SharedPreferences.getInstance()).getInt("userId");
    assert(userId != null);

    await _usersDao.insertFavoriteFood(userId!, foodId);
  }

  Future<void> removeFoodFromFavorites(int userId, int foodId) async {
    return await _usersDao.removeFavoriteFood(userId, foodId);
  }

  Future<void> removeLoggedInUsersFoodFromFavorites(int foodId) async {
    int? userId = (await SharedPreferences.getInstance()).getInt("userId");
    assert(userId != null);

    return await _usersDao.removeFavoriteFood(userId!, foodId);
  }

  Future<bool> isLoggedInUsersFoodFavorite(int foodId) async {
      int? userId = (await SharedPreferences.getInstance()).getInt("userId");
      assert(userId != null);

      return (await _usersDao.findFavoriteFoodByUserIdAndFoodId(userId!, foodId)) != null;
  }

  Future<List<Food>> getUsersFavoriteFoods(int userId) async {
    List<UsersFavoriteFood> usersFavoriteFoods = await _usersDao.findAllFavoriteFoodsByUserId(userId);

    List<int> foodIds = usersFavoriteFoods.map((e) => e.foodId).toList();

    return await _foodsDao.findAllByFoodIds(foodIds);
  }

}