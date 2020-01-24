// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AuthenticationRepository _authRepositoryInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Authentication` (`id` TEXT, `accessToken` TEXT, `idToken` TEXT, `expiredTimeInMilis` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  AuthenticationRepository get authRepository {
    return _authRepositoryInstance ??=
        _$AuthenticationRepository(database, changeListener);
  }
}

class _$AuthenticationRepository extends AuthenticationRepository {
  _$AuthenticationRepository(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _authenticationInsertionAdapter = InsertionAdapter(
            database,
            'Authentication',
            (Authentication item) => <String, dynamic>{
                  'id': item.id,
                  'accessToken': item.accessToken,
                  'idToken': item.idToken,
                  'expiredTimeInMilis': item.expiredTimeInMilis
                }),
        _authenticationUpdateAdapter = UpdateAdapter(
            database,
            'Authentication',
            ['id'],
            (Authentication item) => <String, dynamic>{
                  'id': item.id,
                  'accessToken': item.accessToken,
                  'idToken': item.idToken,
                  'expiredTimeInMilis': item.expiredTimeInMilis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _authenticationMapper = (Map<String, dynamic> row) =>
      Authentication(row['id'] as String, row['accessToken'] as String,
          row['idToken'] as String, row['expiredTimeInMilis'] as int);

  final InsertionAdapter<Authentication> _authenticationInsertionAdapter;

  final UpdateAdapter<Authentication> _authenticationUpdateAdapter;

  @override
  Future<Authentication> getAuthById(String id) async {
    return _queryAdapter.query('SELECT * FROM Authentication WHERE id = ?',
        arguments: <dynamic>[id], mapper: _authenticationMapper);
  }

  @override
  Future<void> removeById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Authentication WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertAuth(Authentication authentication) async {
    await _authenticationInsertionAdapter.insert(
        authentication, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateAuth(Authentication authentication) async {
    await _authenticationUpdateAdapter.update(
        authentication, sqflite.ConflictAlgorithm.abort);
  }
}
