import 'package:meta/meta.dart';

@immutable
class InitializeAction {}

@immutable
class VerifyLocationPermissionAction {
  @override
  String toString() =>
    'VerifyLocationPermissionAction {}';
}

@immutable
class GrantedLocationPermissionAction {
  @override
  String toString() =>
    'GrantedLocationPermissionAction {}';
}

@immutable
class DeniedLocationPermissionAction {
  @override
  String toString() =>
    'DeniedLocationPermissionAction {}';
}
