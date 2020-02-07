import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppies/data/model/authentication.dart';
import 'package:shoppies/data/repository/authentication_repository.dart';
import './bloc.dart';

const AUTHENTICATION_KEY = "app_auth";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository repository;

  AuthenticationBloc({@required this.repository});

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignedIn) {
      yield* _persistAuthenticationData(event);
    } else if (event is SignedOut) {
      yield* _removeAuthenticationData();
    }
  }

  Stream<AuthenticationState> _removeAuthenticationData() async* {
    await this.repository.removeById(AUTHENTICATION_KEY);
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _persistAuthenticationData(
      SignedIn event) async* {
    var auth = await this.repository.getAuthById(AUTHENTICATION_KEY);
    var newAuth = new Authentication(
        AUTHENTICATION_KEY,
        event.accessToken,
        event.idToken,
        event.refreshToken,
        event.expiredTime.millisecondsSinceEpoch);
    if (auth != null) {
      await this.repository.updateAuth(newAuth);
    } else {
      await this.repository.insertAuth(newAuth);
    }
    yield AuthenticationAuthenticated();
  }
}
