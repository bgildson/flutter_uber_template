import 'model.dart';
import '../auth/auth.dart';

AppState appReducer(AppState state, action) =>
  AppState(
    auth: authReducer(state.auth, action),
  );
