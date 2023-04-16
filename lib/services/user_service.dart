
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:umte_project/data/enums/response_enum.dart';
import 'package:umte_project/database/dao/user_dao.dart';
import 'package:umte_project/database/database.dart';

class UserService {
  UserService(UMTEDatabase db) : _usersDao = db.usersDao;

  final UsersDao _usersDao;

  String _hashString(String text) {
    List<int> bytes = utf8.encode(text);
    Digest hash = sha512.convert(bytes);

    return hash.toString();
  }

  void registerUser(String username, String password) async {
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

    return ResponseEnum.success;
  }

}