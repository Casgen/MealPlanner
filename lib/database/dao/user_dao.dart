import 'package:drift/drift.dart';
import 'package:umte_project/database/database.dart';
import 'package:umte_project/database/tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
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
    return await (select(users)..where((tbl) => tbl.username.equals(username))).getSingleOrNull();
  }

}