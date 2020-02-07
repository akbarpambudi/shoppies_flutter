import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthentication extends AuthenticationEvent {}

class SignedIn extends AuthenticationEvent {
  final String accessToken;
  final String idToken;
  final DateTime expiredTime;
  final String refreshToken;

  SignedIn(
      {@required this.accessToken,
      @required this.idToken,
      @required this.expiredTime,
      @required this.refreshToken});
}

class SignedOut extends AuthenticationEvent {}
