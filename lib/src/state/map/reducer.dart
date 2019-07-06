import 'package:redux/redux.dart';

import 'actions.dart';
import 'model.dart';

final mapReducer = combineReducers<MapState>([
  TypedReducer<MapState, SetUserPositionAction>(_setUserPosition),
  TypedReducer<MapState, SetCameraPositionAction>(_setCameraPosition),
]);

MapState _setUserPosition(MapState state, SetUserPositionAction action) =>
  state.copyWith(
    userPosition: action.userPosition
  );

MapState _setCameraPosition(MapState state, SetCameraPositionAction action) =>
  state.copyWith(
    cameraPosition: action.cameraPosition
  );
