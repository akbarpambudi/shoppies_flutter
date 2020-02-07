import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppies/adapter/auth/authentication_adapter.dart';
import 'package:shoppies/adapter/auth/authentication_request.dart';
import 'package:shoppies/bloc/auth/authentication_bloc.dart';
import 'package:shoppies/bloc/auth/bloc.dart';
import 'package:shoppies/exception/auth/auth_exception.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationAdapter authenticationAdapter;
  final AuthenticationBloc authenticationBloc;
  LoginBloc(
      {@required this.authenticationAdapter,
      @required this.authenticationBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginFlowStarted) {
      yield* _startLoginFlow(event);
    }
  }

  Stream<LoginState> _startLoginFlow(LoginFlowStarted event) async* {
    try {
      yield new LoginLoading();
      var response = await this
          .authenticationAdapter
          .login(new AuthenticationRequest(event.username, event.password));
      authenticationBloc.add(new SignedIn(
          accessToken: response.accessToken,
          idToken: response.idToken,
          expiredTime: response.expiredTime,
          refreshToken: response.refreshToken));
      yield new LoginInitial();
    } on AuthenticationException catch (e) {
      yield new LoginFailure(exception: e);
    }
  }
}
