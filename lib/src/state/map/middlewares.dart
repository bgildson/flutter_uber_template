import 'package:location/location.dart';
import 'package:redux/redux.dart';

import '../app/app.dart';
import '../auth/auth.dart';
import 'actions.dart';

final List<Middleware<AppState>> mapMiddlewares = [
  TypedMiddleware<AppState, AuthenticatedAction>(_authenticated),
  TypedMiddleware<AppState, ListenGeolocationAction>(_listenGeolocation),
];

void _authenticated(Store<AppState> store, AuthenticatedAction action, NextDispatcher next) {
  next(action);

  store.dispatch(ListenGeolocationAction());
}

void _listenGeolocation(Store<AppState> store, ListenGeolocationAction action, NextDispatcher next) {
  next(action);

  try {
    // first verify if the user given permission to the app listen for geolocation,
    // if yes, listen, if not, ask for permission
    // after, stay listening the user geolocation
    Location()
      .onLocationChanged()
      .listen((LocationData location) {
        // 
        // print(location);
      });

    // generate condition to listen geolocation, just while either the state have token or UnauthenticatedAction wasn't called,
    // when don't have a token means that the user aren't logged and stop listen geolocation
  } catch (error) {
    // if happen some error, redispatch listen
  }
}
