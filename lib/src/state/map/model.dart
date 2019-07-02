import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
class MapState extends Equatable {
  final LatLng location;
  final double zoom;
  static final double zoomDefault = 16;

  MapState({this.location, double zoom})
    : this.zoom = zoom ?? zoomDefault,
      super([location, zoom]);

  factory MapState.initial() =>
    MapState(
      location: LatLng(-5.8411396, -35.2106268),
      zoom: zoomDefault,
    );

  MapState copyWith({
    LatLng location,
    double zoom,
  }) =>
    MapState(
      location: location ?? this.location,
      zoom: zoom ?? this.zoom,
    );

  @override
  String toString() =>
    'MapState { '
    'location: $location, '
    'zoom: $zoom, '
    '}';
}
