import 'model.dart';
import '../auth/auth.dart';
import '../map/map.dart';

AppState appReducer(AppState state, action) =>
  AppState(
    auth: authReducer(state.auth, action),
    map: mapReducer(state.map, action),
  );
