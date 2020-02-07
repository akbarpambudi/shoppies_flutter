import 'package:floor/floor.dart';

@entity
class Authentication {
  @primaryKey
  final String id;
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final int expiredTimeInMilis;

  Authentication(this.id, this.accessToken, this.idToken, this.refreshToken,
      this.expiredTimeInMilis);
}
