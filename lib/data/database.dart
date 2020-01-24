import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'package:path/path.dart';
import 'package:shoppies/data/model/authentication.dart';
import 'package:shoppies/data/repository/authentication_repository.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Authentication])
abstract class AppDatabase extends FloorDatabase {
  AuthenticationRepository get authRepository;
}
