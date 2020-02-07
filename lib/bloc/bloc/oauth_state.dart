part of 'oauth_bloc.dart';

abstract class OauthState extends Equatable {
  const OauthState();
}

class OauthInitial extends OauthState {
  @override
  List<Object> get props => [];
}

class OauthSuccess extends OauthState {
  @override
  List<Object> get props => [];
}

class OauthFailed extends OauthState {
  @override
  List<Object> get props => [];
}
