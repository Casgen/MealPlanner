// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 0, maxTextLength: 1000),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fibreMeta = const VerificationMeta('fibre');
  @override
  late final GeneratedColumn<double> fibre = GeneratedColumn<double>(
      'fibre', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _carbohydratesMeta =
      const VerificationMeta('carbohydrates');
  @override
  late final GeneratedColumn<double> carbohydrates = GeneratedColumn<double>(
      'carbohydrates', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sugarsMeta = const VerificationMeta('sugars');
  @override
  late final GeneratedColumn<double> sugars = GeneratedColumn<double>(
      'sugars', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fatsMeta = const VerificationMeta('fats');
  @override
  late final GeneratedColumn<double> fats = GeneratedColumn<double>(
      'fats', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
      'units', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        calories,
        fibre,
        carbohydrates,
        sugars,
        fats,
        units
      ];
  @override
  String get aliasedName => _alias ?? 'foods';
  @override
  String get actualTableName => 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('fibre')) {
      context.handle(
          _fibreMeta, fibre.isAcceptableOrUnknown(data['fibre']!, _fibreMeta));
    }
    if (data.containsKey('carbohydrates')) {
      context.handle(
          _carbohydratesMeta,
          carbohydrates.isAcceptableOrUnknown(
              data['carbohydrates']!, _carbohydratesMeta));
    }
    if (data.containsKey('sugars')) {
      context.handle(_sugarsMeta,
          sugars.isAcceptableOrUnknown(data['sugars']!, _sugarsMeta));
    }
    if (data.containsKey('fats')) {
      context.handle(
          _fatsMeta, fats.isAcceptableOrUnknown(data['fats']!, _fatsMeta));
    }
    if (data.containsKey('units')) {
      context.handle(
          _unitsMeta, units.isAcceptableOrUnknown(data['units']!, _unitsMeta));
    } else if (isInserting) {
      context.missing(_unitsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories']),
      fibre: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fibre']),
      carbohydrates: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbohydrates']),
      sugars: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sugars']),
      fats: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fats']),
      units: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}units'])!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String name;
  final String description;
  final double? calories;
  final double? fibre;
  final double? carbohydrates;
  final double? sugars;
  final double? fats;
  final String units;
  const Food(
      {required this.id,
      required this.name,
      required this.description,
      this.calories,
      this.fibre,
      this.carbohydrates,
      this.sugars,
      this.fats,
      required this.units});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || calories != null) {
      map['calories'] = Variable<double>(calories);
    }
    if (!nullToAbsent || fibre != null) {
      map['fibre'] = Variable<double>(fibre);
    }
    if (!nullToAbsent || carbohydrates != null) {
      map['carbohydrates'] = Variable<double>(carbohydrates);
    }
    if (!nullToAbsent || sugars != null) {
      map['sugars'] = Variable<double>(sugars);
    }
    if (!nullToAbsent || fats != null) {
      map['fats'] = Variable<double>(fats);
    }
    map['units'] = Variable<String>(units);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      calories: calories == null && nullToAbsent
          ? const Value.absent()
          : Value(calories),
      fibre:
          fibre == null && nullToAbsent ? const Value.absent() : Value(fibre),
      carbohydrates: carbohydrates == null && nullToAbsent
          ? const Value.absent()
          : Value(carbohydrates),
      sugars:
          sugars == null && nullToAbsent ? const Value.absent() : Value(sugars),
      fats: fats == null && nullToAbsent ? const Value.absent() : Value(fats),
      units: Value(units),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      calories: serializer.fromJson<double?>(json['calories']),
      fibre: serializer.fromJson<double?>(json['fibre']),
      carbohydrates: serializer.fromJson<double?>(json['carbohydrates']),
      sugars: serializer.fromJson<double?>(json['sugars']),
      fats: serializer.fromJson<double?>(json['fats']),
      units: serializer.fromJson<String>(json['units']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'calories': serializer.toJson<double?>(calories),
      'fibre': serializer.toJson<double?>(fibre),
      'carbohydrates': serializer.toJson<double?>(carbohydrates),
      'sugars': serializer.toJson<double?>(sugars),
      'fats': serializer.toJson<double?>(fats),
      'units': serializer.toJson<String>(units),
    };
  }

  Food copyWith(
          {int? id,
          String? name,
          String? description,
          Value<double?> calories = const Value.absent(),
          Value<double?> fibre = const Value.absent(),
          Value<double?> carbohydrates = const Value.absent(),
          Value<double?> sugars = const Value.absent(),
          Value<double?> fats = const Value.absent(),
          String? units}) =>
      Food(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        calories: calories.present ? calories.value : this.calories,
        fibre: fibre.present ? fibre.value : this.fibre,
        carbohydrates:
            carbohydrates.present ? carbohydrates.value : this.carbohydrates,
        sugars: sugars.present ? sugars.value : this.sugars,
        fats: fats.present ? fats.value : this.fats,
        units: units ?? this.units,
      );
  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('calories: $calories, ')
          ..write('fibre: $fibre, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('sugars: $sugars, ')
          ..write('fats: $fats, ')
          ..write('units: $units')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, calories, fibre,
      carbohydrates, sugars, fats, units);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.calories == this.calories &&
          other.fibre == this.fibre &&
          other.carbohydrates == this.carbohydrates &&
          other.sugars == this.sugars &&
          other.fats == this.fats &&
          other.units == this.units);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double?> calories;
  final Value<double?> fibre;
  final Value<double?> carbohydrates;
  final Value<double?> sugars;
  final Value<double?> fats;
  final Value<String> units;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.calories = const Value.absent(),
    this.fibre = const Value.absent(),
    this.carbohydrates = const Value.absent(),
    this.sugars = const Value.absent(),
    this.fats = const Value.absent(),
    this.units = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.calories = const Value.absent(),
    this.fibre = const Value.absent(),
    this.carbohydrates = const Value.absent(),
    this.sugars = const Value.absent(),
    this.fats = const Value.absent(),
    required String units,
  })  : name = Value(name),
        description = Value(description),
        units = Value(units);
  static Insertable<Food> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? calories,
    Expression<double>? fibre,
    Expression<double>? carbohydrates,
    Expression<double>? sugars,
    Expression<double>? fats,
    Expression<String>? units,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (calories != null) 'calories': calories,
      if (fibre != null) 'fibre': fibre,
      if (carbohydrates != null) 'carbohydrates': carbohydrates,
      if (sugars != null) 'sugars': sugars,
      if (fats != null) 'fats': fats,
      if (units != null) 'units': units,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<double?>? calories,
      Value<double?>? fibre,
      Value<double?>? carbohydrates,
      Value<double?>? sugars,
      Value<double?>? fats,
      Value<String>? units}) {
    return FoodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      fibre: fibre ?? this.fibre,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      sugars: sugars ?? this.sugars,
      fats: fats ?? this.fats,
      units: units ?? this.units,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (fibre.present) {
      map['fibre'] = Variable<double>(fibre.value);
    }
    if (carbohydrates.present) {
      map['carbohydrates'] = Variable<double>(carbohydrates.value);
    }
    if (sugars.present) {
      map['sugars'] = Variable<double>(sugars.value);
    }
    if (fats.present) {
      map['fats'] = Variable<double>(fats.value);
    }
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('calories: $calories, ')
          ..write('fibre: $fibre, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('sugars: $sugars, ')
          ..write('fats: $fats, ')
          ..write('units: $units')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 5, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 12, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, username, password];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  const User(
      {required this.id, required this.username, required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({int? id, String? username, String? password}) => User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
  })  : username = Value(username),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id, Value<String>? username, Value<String>? password}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UsersMealsTable extends UsersMeals
    with TableInfo<$UsersMealsTable, UsersMeal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersMealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, name];
  @override
  String get aliasedName => _alias ?? 'users_meals';
  @override
  String get actualTableName => 'users_meals';
  @override
  VerificationContext validateIntegrity(Insertable<UsersMeal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersMeal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersMeal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $UsersMealsTable createAlias(String alias) {
    return $UsersMealsTable(attachedDatabase, alias);
  }
}

class UsersMeal extends DataClass implements Insertable<UsersMeal> {
  final int id;
  final int userId;
  final String name;
  const UsersMeal({required this.id, required this.userId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    return map;
  }

  UsersMealsCompanion toCompanion(bool nullToAbsent) {
    return UsersMealsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
    );
  }

  factory UsersMeal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersMeal(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
    };
  }

  UsersMeal copyWith({int? id, int? userId, String? name}) => UsersMeal(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('UsersMeal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersMeal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name);
}

class UsersMealsCompanion extends UpdateCompanion<UsersMeal> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  const UsersMealsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
  });
  UsersMealsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
  })  : userId = Value(userId),
        name = Value(name);
  static Insertable<UsersMeal> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
    });
  }

  UsersMealsCompanion copyWith(
      {Value<int>? id, Value<int>? userId, Value<String>? name}) {
    return UsersMealsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersMealsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $UsersMealsIngredientsTable extends UsersMealsIngredients
    with TableInfo<$UsersMealsIngredientsTable, UsersMealsIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersMealsIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMealIdMeta =
      const VerificationMeta('userMealId');
  @override
  late final GeneratedColumn<int> userMealId = GeneratedColumn<int>(
      'user_meal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users_meals (id)'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES foods (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userMealId, foodId, amount];
  @override
  String get aliasedName => _alias ?? 'users_meals_ingredients';
  @override
  String get actualTableName => 'users_meals_ingredients';
  @override
  VerificationContext validateIntegrity(
      Insertable<UsersMealsIngredient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_meal_id')) {
      context.handle(
          _userMealIdMeta,
          userMealId.isAcceptableOrUnknown(
              data['user_meal_id']!, _userMealIdMeta));
    } else if (isInserting) {
      context.missing(_userMealIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersMealsIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersMealsIngredient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userMealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_meal_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $UsersMealsIngredientsTable createAlias(String alias) {
    return $UsersMealsIngredientsTable(attachedDatabase, alias);
  }
}

class UsersMealsIngredient extends DataClass
    implements Insertable<UsersMealsIngredient> {
  final int id;
  final int userMealId;
  final int foodId;
  final int amount;
  const UsersMealsIngredient(
      {required this.id,
      required this.userMealId,
      required this.foodId,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_meal_id'] = Variable<int>(userMealId);
    map['food_id'] = Variable<int>(foodId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  UsersMealsIngredientsCompanion toCompanion(bool nullToAbsent) {
    return UsersMealsIngredientsCompanion(
      id: Value(id),
      userMealId: Value(userMealId),
      foodId: Value(foodId),
      amount: Value(amount),
    );
  }

  factory UsersMealsIngredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersMealsIngredient(
      id: serializer.fromJson<int>(json['id']),
      userMealId: serializer.fromJson<int>(json['userMealId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userMealId': serializer.toJson<int>(userMealId),
      'foodId': serializer.toJson<int>(foodId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  UsersMealsIngredient copyWith(
          {int? id, int? userMealId, int? foodId, int? amount}) =>
      UsersMealsIngredient(
        id: id ?? this.id,
        userMealId: userMealId ?? this.userMealId,
        foodId: foodId ?? this.foodId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('UsersMealsIngredient(')
          ..write('id: $id, ')
          ..write('userMealId: $userMealId, ')
          ..write('foodId: $foodId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userMealId, foodId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersMealsIngredient &&
          other.id == this.id &&
          other.userMealId == this.userMealId &&
          other.foodId == this.foodId &&
          other.amount == this.amount);
}

class UsersMealsIngredientsCompanion
    extends UpdateCompanion<UsersMealsIngredient> {
  final Value<int> id;
  final Value<int> userMealId;
  final Value<int> foodId;
  final Value<int> amount;
  const UsersMealsIngredientsCompanion({
    this.id = const Value.absent(),
    this.userMealId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  UsersMealsIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required int userMealId,
    required int foodId,
    required int amount,
  })  : userMealId = Value(userMealId),
        foodId = Value(foodId),
        amount = Value(amount);
  static Insertable<UsersMealsIngredient> custom({
    Expression<int>? id,
    Expression<int>? userMealId,
    Expression<int>? foodId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userMealId != null) 'user_meal_id': userMealId,
      if (foodId != null) 'food_id': foodId,
      if (amount != null) 'amount': amount,
    });
  }

  UsersMealsIngredientsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userMealId,
      Value<int>? foodId,
      Value<int>? amount}) {
    return UsersMealsIngredientsCompanion(
      id: id ?? this.id,
      userMealId: userMealId ?? this.userMealId,
      foodId: foodId ?? this.foodId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userMealId.present) {
      map['user_meal_id'] = Variable<int>(userMealId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersMealsIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('userMealId: $userMealId, ')
          ..write('foodId: $foodId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $UsersConsumedMealsTable extends UsersConsumedMeals
    with TableInfo<$UsersConsumedMealsTable, UsersConsumedMeal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersConsumedMealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _usersMealIdMeta =
      const VerificationMeta('usersMealId');
  @override
  late final GeneratedColumn<int> usersMealId = GeneratedColumn<int>(
      'users_meal_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _typeOfMealMeta =
      const VerificationMeta('typeOfMeal');
  @override
  late final GeneratedColumnWithTypeConverter<TypeOfMeal, String> typeOfMeal =
      GeneratedColumn<String>('type_of_meal', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TypeOfMeal>(
              $UsersConsumedMealsTable.$convertertypeOfMeal);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCheckedMeta =
      const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked =
      GeneratedColumn<bool>('is_checked', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_checked" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, foodId, usersMealId, date, typeOfMeal, amount, isChecked];
  @override
  String get aliasedName => _alias ?? 'users_consumed_meals';
  @override
  String get actualTableName => 'users_consumed_meals';
  @override
  VerificationContext validateIntegrity(Insertable<UsersConsumedMeal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    }
    if (data.containsKey('users_meal_id')) {
      context.handle(
          _usersMealIdMeta,
          usersMealId.isAcceptableOrUnknown(
              data['users_meal_id']!, _usersMealIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_typeOfMealMeta, const VerificationResult.success());
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    } else if (isInserting) {
      context.missing(_isCheckedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersConsumedMeal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersConsumedMeal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id']),
      usersMealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}users_meal_id']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      typeOfMeal: $UsersConsumedMealsTable.$convertertypeOfMeal.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}type_of_meal'])!),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      isChecked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_checked'])!,
    );
  }

  @override
  $UsersConsumedMealsTable createAlias(String alias) {
    return $UsersConsumedMealsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TypeOfMeal, String, String> $convertertypeOfMeal =
      const EnumNameConverter<TypeOfMeal>(TypeOfMeal.values);
}

class UsersConsumedMeal extends DataClass
    implements Insertable<UsersConsumedMeal> {
  final int id;
  final int userId;
  final int? foodId;
  final int? usersMealId;
  final DateTime date;
  final TypeOfMeal typeOfMeal;
  final int amount;
  final bool isChecked;
  const UsersConsumedMeal(
      {required this.id,
      required this.userId,
      this.foodId,
      this.usersMealId,
      required this.date,
      required this.typeOfMeal,
      required this.amount,
      required this.isChecked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<int>(foodId);
    }
    if (!nullToAbsent || usersMealId != null) {
      map['users_meal_id'] = Variable<int>(usersMealId);
    }
    map['date'] = Variable<DateTime>(date);
    {
      final converter = $UsersConsumedMealsTable.$convertertypeOfMeal;
      map['type_of_meal'] = Variable<String>(converter.toSql(typeOfMeal));
    }
    map['amount'] = Variable<int>(amount);
    map['is_checked'] = Variable<bool>(isChecked);
    return map;
  }

  UsersConsumedMealsCompanion toCompanion(bool nullToAbsent) {
    return UsersConsumedMealsCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId:
          foodId == null && nullToAbsent ? const Value.absent() : Value(foodId),
      usersMealId: usersMealId == null && nullToAbsent
          ? const Value.absent()
          : Value(usersMealId),
      date: Value(date),
      typeOfMeal: Value(typeOfMeal),
      amount: Value(amount),
      isChecked: Value(isChecked),
    );
  }

  factory UsersConsumedMeal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersConsumedMeal(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      foodId: serializer.fromJson<int?>(json['foodId']),
      usersMealId: serializer.fromJson<int?>(json['usersMealId']),
      date: serializer.fromJson<DateTime>(json['date']),
      typeOfMeal: $UsersConsumedMealsTable.$convertertypeOfMeal
          .fromJson(serializer.fromJson<String>(json['typeOfMeal'])),
      amount: serializer.fromJson<int>(json['amount']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'foodId': serializer.toJson<int?>(foodId),
      'usersMealId': serializer.toJson<int?>(usersMealId),
      'date': serializer.toJson<DateTime>(date),
      'typeOfMeal': serializer.toJson<String>(
          $UsersConsumedMealsTable.$convertertypeOfMeal.toJson(typeOfMeal)),
      'amount': serializer.toJson<int>(amount),
      'isChecked': serializer.toJson<bool>(isChecked),
    };
  }

  UsersConsumedMeal copyWith(
          {int? id,
          int? userId,
          Value<int?> foodId = const Value.absent(),
          Value<int?> usersMealId = const Value.absent(),
          DateTime? date,
          TypeOfMeal? typeOfMeal,
          int? amount,
          bool? isChecked}) =>
      UsersConsumedMeal(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId.present ? foodId.value : this.foodId,
        usersMealId: usersMealId.present ? usersMealId.value : this.usersMealId,
        date: date ?? this.date,
        typeOfMeal: typeOfMeal ?? this.typeOfMeal,
        amount: amount ?? this.amount,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('UsersConsumedMeal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('usersMealId: $usersMealId, ')
          ..write('date: $date, ')
          ..write('typeOfMeal: $typeOfMeal, ')
          ..write('amount: $amount, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, foodId, usersMealId, date, typeOfMeal, amount, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersConsumedMeal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.usersMealId == this.usersMealId &&
          other.date == this.date &&
          other.typeOfMeal == this.typeOfMeal &&
          other.amount == this.amount &&
          other.isChecked == this.isChecked);
}

class UsersConsumedMealsCompanion extends UpdateCompanion<UsersConsumedMeal> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int?> foodId;
  final Value<int?> usersMealId;
  final Value<DateTime> date;
  final Value<TypeOfMeal> typeOfMeal;
  final Value<int> amount;
  final Value<bool> isChecked;
  const UsersConsumedMealsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.usersMealId = const Value.absent(),
    this.date = const Value.absent(),
    this.typeOfMeal = const Value.absent(),
    this.amount = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  UsersConsumedMealsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.foodId = const Value.absent(),
    this.usersMealId = const Value.absent(),
    required DateTime date,
    required TypeOfMeal typeOfMeal,
    required int amount,
    required bool isChecked,
  })  : userId = Value(userId),
        date = Value(date),
        typeOfMeal = Value(typeOfMeal),
        amount = Value(amount),
        isChecked = Value(isChecked);
  static Insertable<UsersConsumedMeal> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? foodId,
    Expression<int>? usersMealId,
    Expression<DateTime>? date,
    Expression<String>? typeOfMeal,
    Expression<int>? amount,
    Expression<bool>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodId != null) 'food_id': foodId,
      if (usersMealId != null) 'users_meal_id': usersMealId,
      if (date != null) 'date': date,
      if (typeOfMeal != null) 'type_of_meal': typeOfMeal,
      if (amount != null) 'amount': amount,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  UsersConsumedMealsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int?>? foodId,
      Value<int?>? usersMealId,
      Value<DateTime>? date,
      Value<TypeOfMeal>? typeOfMeal,
      Value<int>? amount,
      Value<bool>? isChecked}) {
    return UsersConsumedMealsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      usersMealId: usersMealId ?? this.usersMealId,
      date: date ?? this.date,
      typeOfMeal: typeOfMeal ?? this.typeOfMeal,
      amount: amount ?? this.amount,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (usersMealId.present) {
      map['users_meal_id'] = Variable<int>(usersMealId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (typeOfMeal.present) {
      final converter = $UsersConsumedMealsTable.$convertertypeOfMeal;
      map['type_of_meal'] = Variable<String>(converter.toSql(typeOfMeal.value));
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersConsumedMealsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('usersMealId: $usersMealId, ')
          ..write('date: $date, ')
          ..write('typeOfMeal: $typeOfMeal, ')
          ..write('amount: $amount, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }
}

abstract class _$UMTEDatabase extends GeneratedDatabase {
  _$UMTEDatabase(QueryExecutor e) : super(e);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UsersMealsTable usersMeals = $UsersMealsTable(this);
  late final $UsersMealsIngredientsTable usersMealsIngredients =
      $UsersMealsIngredientsTable(this);
  late final $UsersConsumedMealsTable usersConsumedMeals =
      $UsersConsumedMealsTable(this);
  late final FoodsDao foodsDao = FoodsDao(this as UMTEDatabase);
  late final UsersDao usersDao = UsersDao(this as UMTEDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [foods, users, usersMeals, usersMealsIngredients, usersConsumedMeals];
}
