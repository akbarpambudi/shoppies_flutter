import 'package:floor/floor.dart';
import 'package:shoppies/data/model/authentication.dart';

@dao
abstract class AuthenticationRepository {
  @Query("SELECT * FROM Authentication WHERE id = :id")
  Future<Authentication> getAuthById(String id);

  @update
  Future<void> updateAuth(Authentication authentication);

  @insert
  Future<void> insertAuth(Authentication authentication);
  @Query("DELETE FROM Authentication WHERE id = :id")
  Future<void> removeById(String id);
}
