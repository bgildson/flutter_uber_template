import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AppState extends Equatable {
  AppState() : super([]);

  factory AppState.initial() =>
    AppState();
}
