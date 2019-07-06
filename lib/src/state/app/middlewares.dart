import 'package:flutter_uber_template/src/state/state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';

import '../auth/auth.dart';
import '../map/map.dart';
import 'model.dart';

List<Middleware<AppState>> createAllMiddlewares() =>
  [
    TypedMiddleware<AppState, InitializeAction>(_initialize),
    TypedMiddleware<AppState, VerifyLocationPermissionAction>(_verifyLocationPermission),
    ...authMiddlewares,
    ...mapMiddlewares,
  ];

void _initialize(Store<AppState> store, action, NextDispatcher next) {
  next(action);

  store.dispatch(VerifyLocationPermissionAction());
}

void _verifyLocationPermission(Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  try {
    final PermissionStatus permissionStatus = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if (permissionStatus == PermissionStatus.granted) {
      store.dispatch(GrantedLocationPermissionAction());
    } else {
      store.dispatch(DeniedLocationPermissionAction());
    }
  } catch (err) {
    //
  }
}
