class AuthenticationException implements Exception {
  final String message;
  final String code;
  AuthenticationException({this.code, this.message});
}
