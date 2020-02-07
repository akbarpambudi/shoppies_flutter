part of 'oauth_bloc.dart';

abstract class OauthEvent extends Equatable {
  const OauthEvent();
}

class OauthStarted extends OauthEvent {
  final BuildContext context;

  const OauthStarted(this.context);

  @override
  List<Object> get props => [];
}
