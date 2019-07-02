import 'package:meta/meta.dart';

@immutable
class ListenGeolocationAction {
  @override
  String toString() =>
    'ListenGeolocationAction {}';
}

@immutable
class ListenGeolocationSuccessAction {
  final double latitude;
  final double longitude;

  ListenGeolocationSuccessAction({this.latitude, this.longitude});

  @override
  String toString() =>
    'ListenGeolocationSuccessAction { '
    'latitude: $latitude, '
    'longitude: $longitude, '
    '}';
}
