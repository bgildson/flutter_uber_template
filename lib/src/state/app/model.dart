import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../auth/auth.dart';

@immutable
class AppState extends Equatable {
  final AuthState auth;

  AppState({
    @required this.auth
  }) : super([auth]);

  factory AppState.initial() =>
    AppState(
      auth: AuthState.initial(),
    );

  @override
  String toString() =>
    'AppState { '
    'auth: $auth, '
    '}';
}
