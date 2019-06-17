import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_uber_template/src/entities/entities.dart';

@immutable
class AuthState extends Equatable {
  final bool userLoading;
  final User user;
  final String token;

  AuthState({
    this.userLoading,
    this.user,
    this.token,
  }) : super([userLoading, user, token]);

  factory AuthState.initial() =>
    AuthState(
      userLoading: false,
      user: User.empty(),
      token: '',
    );

  AuthState copyWith({
    bool userLoading,
    User user,
    String token,
  }) =>
    AuthState(
      userLoading: userLoading ?? this.userLoading,
      user: user ?? this.user,
      token: token ?? this.token,
    );

  @override
  String toString() =>
    'AuthState { '
    'userLoading: $userLoading, '
    'user: $user, '
    'token: $token, '
    '}';
}
