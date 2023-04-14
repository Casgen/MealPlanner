import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:umte_project/data/enums/type_of_meal.dart';
import 'package:umte_project/database/dao/foods_dao.dart';
import 'package:umte_project/database/data.dart';
import 'package:umte_project/database/tables.dart';

part "database.g.dart";

bool inDevelopment = true;

@DriftDatabase(
  tables: [Foods, Users, UsersMeals, UsersMealsIngredients, UsersConsumedMeals],
  daos: [FoodsDao]
)
class UMTEDatabase extends _$UMTEDatabase {

  UMTEDatabase() : super(_openConnection());
  UMTEDatabase.withQueryExecutor(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        for (Food food in getFoodsData()) {
          await into(foods).insert(food);
        }
      },
    );
  }
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (inDevelopment && await file.exists()) {
      file.delete();
    }

    return NativeDatabase.createInBackground(file);
  });
}

/*QueryExecutor databaseWithDefaultAsset(File file, String asset) {
  // A LazyDatabase lets us do async initialization work.
  return LazyDatabase(() async {
    if (!await file.exists()) {
      // Database does not exist yet, use default from asset
      final content = await rootBundle.load(asset);
      await file.parent.create(recursive: true);
      await file.writeAsBytes(content.buffer.asUint8List(0));
    }
  });
}*/


