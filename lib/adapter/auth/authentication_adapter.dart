import 'package:shoppies/adapter/auth/authentication_response.dart';
import 'package:shoppies/adapter/auth/authentication_request.dart';

abstract class AuthenticationAdapter {
  Future<AuthenticationResponse> login(AuthenticationRequest request);
}
