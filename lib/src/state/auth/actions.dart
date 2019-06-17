import 'package:meta/meta.dart';

import 'package:flutter_uber_template/src/entities/entities.dart';

@immutable
class AuthenticatedAction {
  final String token;
  final User user;

  AuthenticatedAction({this.token, this.user});

  @override
  String toString() =>
    'AuthenticatedAction { token: $token, user: $user, }';
}

@immutable
class UnauthenticatedAction {
  @override
  String toString() =>
    'UnauthenticatedAction';
}

@immutable
class LoadUserAction {
  @override
  String toString() =>
    'LoadUserAction';
}

@immutable
class LoadUserSuccessAction {
  final User user;

  LoadUserSuccessAction({this.user});

  @override
  String toString() =>
    'LoadUserSuccessAction { user: $user }';
}

@immutable
class LoadUserFailAction {
  final String message;

  LoadUserFailAction({this.message});

  @override
  String toString() =>
    'LoadUserFailAction { message: $message }';
}
