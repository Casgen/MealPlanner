import 'package:drift/native.dart';
import 'package:umte_project/database/database.dart';
import 'package:test/test.dart';

void main() {
  UMTEDatabase? database;

  setUp(() {
    database = UMTEDatabase.withQueryExecutor(NativeDatabase.memory());
  });

  tearDown(() async {
    await database?.close();
  });

  test('Obtaining users meals ingredients', () {
    //final rows = database?.getFoodByName("Banana");
    //print(rows);
  });
}
