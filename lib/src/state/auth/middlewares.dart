import 'package:redux/redux.dart';

import '../../entities/entities.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';
import '../app/actions.dart';
import '../app/model.dart';
import 'actions.dart';

final List<Middleware<AppState>> authMiddlewares = [
  TypedMiddleware<AppState, InitializeAction>(_initialize),
  TypedMiddleware<AppState, AuthenticatedAction>(_authenticated),
  TypedMiddleware<AppState, LoadUserAction>(_loadUser),
];

_initialize(Store<AppState> store, InitializeAction action, NextDispatcher next) async {
  next(action);

  try {
    // in a production app, change this to get the token from a local bucket(like shared_preferences), 
    // in this case I will use a fixed token to simulate that the user ever is logged
    final token = 'token';

    final User user = await UsersService.getRandom();

    store.dispatch(AuthenticatedAction(token: token, user: user));
  } catch (error) {
    store.dispatch(UnauthenticatedAction());
  }
}

_authenticated(Store<AppState> store, AuthenticatedAction action, NextDispatcher next) {
  next(action);
  // when authenticated, load the current user
  store.dispatch(LoadUserAction());
}

_loadUser(Store<AppState> store, LoadUserAction action, NextDispatcher next) async {
  next(action);

  try {
    // would use the local token to get the user,
    // but will get a random user, just for test
    final User user = await UsersService.getRandom();

    store.dispatch(LoadUserSuccessAction(user: user));
  } catch (error) {
    store.dispatch(LoadUserFailAction(message: parseErrorToMessage(error)));
  }
}
