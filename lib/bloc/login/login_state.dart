import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppies/exception/auth/auth_exception.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final AuthenticationException exception;
  LoginFailure({@required this.exception});
  List<Object> get props => [exception];
}
