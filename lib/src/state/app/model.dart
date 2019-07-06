import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../auth/auth.dart';
import '../map/map.dart';

@immutable
class AppState extends Equatable {
  final AuthState auth;
  final MapState map;

  AppState({
    @required this.auth,
    @required this.map,
  }) : super([auth, map]);

  factory AppState.initial() =>
    AppState(
      auth: AuthState.initial(),
      map: MapState.initial(),
    );

  @override
  String toString() =>
    'AppState { '
    'auth: $auth, '
    'map: $map, '
    '}';
}
