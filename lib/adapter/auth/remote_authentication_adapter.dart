import 'package:shoppies/adapter/auth/authentication_request.dart';
import 'package:shoppies/adapter/auth/authentication_response.dart';
import 'package:shoppies/adapter/auth/authentication_adapter.dart';
import 'package:shoppies/exception/auth/auth_exception.dart';

class RemoteAuthenticationAdapter implements AuthenticationAdapter {
  @override
  Future<AuthenticationResponse> login(AuthenticationRequest request) {
    return Future.delayed(Duration(seconds: 3), () {
      if (request.username != "aku" && request.password != "123456") {
        throw new AuthenticationException(
            code: "bad.credential", message: "Username or Password is invalid");
      }
      var response = new AuthenticationResponse();
      response.accessToken = "xx-x-xx";
      response.expiredTime = DateTime.now();
      response.idToken = "xx-xx-xx";
      return response;
    });
  }
}
