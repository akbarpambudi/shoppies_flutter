import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oh_auth_2/authenticator.dart';
import 'package:oh_auth_2/models/token.dart';
import 'package:shoppies/bloc/auth/bloc.dart';

part 'oauth_event.dart';
part 'oauth_state.dart';

class OauthBloc extends Bloc<OauthEvent, OauthState> {
  final AuthenticationBloc authenticationBloc;

  OauthBloc({this.authenticationBloc});

  @override
  OauthState get initialState => OauthInitial();

  @override
  Stream<OauthState> mapEventToState(
    OauthEvent event,
  ) async* {
    if (event is OauthStarted) {
      yield* _startOauthFlow(event as OauthStarted);
    }
  }

  Stream<OauthState> _startOauthFlow(OauthStarted started) async* {
    Token token = await Authenticator(started.context).getAccessToken(
        "http://localhost:4200",
        "https://dev-keycloak.tunaiku.com/auth/realms/Development/protocol/openid-connect/auth",
        "https://dev-keycloak.tunaiku.com/auth/realms/Development/protocol/openid-connect/token",
        "tnk-cms-web");

    this.authenticationBloc.add(SignedIn(
        accessToken: token.accessToken,
        expiredTime:
            DateTime.now().add(Duration(milliseconds: token.expiresIn)),
        idToken: token.accessToken,
        refreshToken: token.refreshToken));
    yield OauthSuccess();
  }
}
