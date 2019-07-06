import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
class MapState extends Equatable {
  final LatLng userPosition;
  final LatLng cameraPosition;
  final double zoom;
  static final double zoomDefault = 16;

  MapState({this.userPosition, this.cameraPosition, this.zoom})
    : super([userPosition, cameraPosition, zoom]);

  factory MapState.initial() =>
    MapState(
      userPosition: null,
      cameraPosition: null,
      zoom: zoomDefault,
    );

  MapState copyWith({
    LatLng userPosition,
    LatLng cameraPosition,
    double zoom,
  }) =>
    MapState(
      userPosition: userPosition ?? this.userPosition,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      zoom: zoom ?? this.zoom,
    );

  Map<String, dynamic> toJson() =>
    {
      'user_position': {
        'latitude': userPosition.latitude,
        'longitude': userPosition.longitude
      },
      'camera_position': {
        'latitude': cameraPosition.latitude,
        'longitude': cameraPosition.longitude
      },
      'zoom': zoom,
    };

  MapState fromJson(Map<String, dynamic> json) =>
    MapState(
      userPosition: LatLng(
        double.tryParse(json['user_position']['latitude']),
        double.tryParse(json['user_position']['longitude'])
      ),
      cameraPosition: LatLng(
        double.tryParse(json['camera_position']['latitude']),
        double.tryParse(json['camera_position']['longitude'])
      ),
      zoom: double.tryParse(json['zoom']),
    );

  @override
  String toString() =>
    'MapState { '
    'userPosition: $userPosition, '
    'cameraPosition: $cameraPosition, '
    'zoom: $zoom, '
    '}';
}
