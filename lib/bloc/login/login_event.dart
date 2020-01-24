import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => [];
}

class LoginFlowStarted extends LoginEvent {
  final String username;
  final String password;

  LoginFlowStarted({@required this.username, @required this.password});

  List<Object> get props => [this.username, this.password];
}
