import 'package:get/get.dart';
import 'package:umte_project/database/database.dart';

import '../database/dao/foods_dao.dart';

class FoodsService {

  final FoodsDao _foodsDao = Get.find<UMTEDatabase>().foodsDao;

  Future<List<Food>> searchFoods(String query) async {
    return await _foodsDao.findByQuery(query);
  }

  Future<Food> getFood(int foodId) {
    return _foodsDao.findById(foodId);
  }

}