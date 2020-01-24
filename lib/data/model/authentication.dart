import 'package:floor/floor.dart';

@entity
class Authentication {
  @primaryKey
  final String id;
  final String accessToken;
  final String idToken;
  final int expiredTimeInMilis;

  Authentication(
      this.id, this.accessToken, this.idToken, this.expiredTimeInMilis);
}
