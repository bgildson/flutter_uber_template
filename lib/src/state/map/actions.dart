import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
class ListenGeolocationAction {
  @override
  String toString() =>
    'ListenGeolocationAction {}';
}

@immutable
class SetUserPositionAction {
  final LatLng userPosition;

  SetUserPositionAction({this.userPosition});

  @override
  String toString() =>
    'SetUserPositionAction { '
    'userPosition: $userPosition, '
    '}';
}

@immutable
class SetCameraPositionAction {
  final LatLng cameraPosition;

  SetCameraPositionAction({this.cameraPosition});

  @override
  String toString() =>
    'SetCameraPositionAction { '
    'cameraPosition: $cameraPosition, '
    '}';
}
