import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

import '../app/app.dart';
import '../auth/auth.dart';
import '../map/map.dart';
import 'actions.dart';

final List<Middleware<AppState>> mapMiddlewares = [
  TypedMiddleware<AppState, AuthenticatedAction>(_authenticated),
  TypedMiddleware<AppState, ListenGeolocationAction>(_listenGeolocation),
];

void _authenticated(Store<AppState> store, AuthenticatedAction action, NextDispatcher next) {
  next(action);

  store.dispatch(ListenGeolocationAction());
}

void _listenGeolocation(Store<AppState> store, ListenGeolocationAction action, NextDispatcher next) async {
  next(action);

  try {
    final geolocator = Geolocator();
    final Position position = await geolocator.getCurrentPosition();
    store.dispatch(SetUserPositionAction(userPosition: LatLng(position.latitude, position.longitude)));
    store.dispatch(SetCameraPositionAction(cameraPosition: LatLng(position.latitude, position.longitude)));

    // first verify if the user given permission to the app listen for geolocation,
    // if yes, listen, if not, ask for permission
    // after, stay listening the user geolocation
    Observable(geolocator.getPositionStream())
      .debounceTime(Duration(milliseconds: 500))
      .listen((Position position) {
        store.dispatch(SetUserPositionAction(userPosition: LatLng(position.latitude, position.longitude)));
      }, cancelOnError: false);

    // generate condition to listen geolocation, just while either the state have token or UnauthenticatedAction wasn't called,
    // when don't have a token means that the user aren't logged and stop listen geolocation
  } catch (error) {
    // if occur some error, redispatch listen
  }
}
