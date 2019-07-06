import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app/app.dart';
import 'model.dart';

MapState selectMapState(AppState state) =>
  state.map;

LatLng selectMapUserPosition(AppState state) =>
  selectMapState(state).userPosition;

LatLng selectMapCameraPosition(AppState state) =>
  selectMapState(state).cameraPosition;

double selectMapZoom(AppState state) =>
  selectMapState(state).zoom;
