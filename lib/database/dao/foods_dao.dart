

import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';

import '../tables.dart';

part "foods_dao.g.dart";

@DriftAccessor(tables: [Foods])
class FoodsDao extends DatabaseAccessor<UMTEDatabase> with _$FoodsDaoMixin {

  FoodsDao(UMTEDatabase db) : super(db);

  Future<List<Food>> getFoods() async {
    return await (select(foods)).get();
  }

  Future<Food> getFood(int id) async {
    Food food =  await (select(foods)..where((tbl) => tbl.id.equals(id))).getSingle();
    return food;
  }

}