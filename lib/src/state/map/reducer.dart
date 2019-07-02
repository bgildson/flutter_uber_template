import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'model.dart';

final mapReducer = combineReducers<MapState>([
  TypedReducer<MapState, ListenGeolocationSuccessAction>(_listenGeolocationSuccess)
]);

MapState _listenGeolocationSuccess(MapState state, ListenGeolocationSuccessAction action) =>
  state.copyWith(
    location: LatLng(action.latitude, action.longitude)
  );
