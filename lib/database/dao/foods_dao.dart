import 'package:drift/drift.dart';
import 'package:format/format.dart';
import 'package:umte_project/database/database.dart';

import '../tables.dart';

part "foods_dao.g.dart";

@DriftAccessor(tables: [Foods])
class FoodsDao extends DatabaseAccessor<UMTEDatabase> with _$FoodsDaoMixin {

  FoodsDao(UMTEDatabase db) : super(db);

  Future<List<Food>> findAll() {
    return (select(foods)).get();
  }

  Future<Food?> findById(int id) {
    return (select(foods)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Food>> findByQuery(String query) {
    return (select(foods)..where((tbl) => tbl.name.like(format("%{0}%", query)))).get();
  }

  Future<List<Food>> findAllByFoodIds(List<int> foodIds) {
    return (select(foods)..where((tbl) => tbl.id.isIn(foodIds))).get();
  }

}
