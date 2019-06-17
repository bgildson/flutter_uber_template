import 'package:redux/redux.dart';

import 'actions.dart';
import 'model.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthenticatedAction>(_authenticated),
  TypedReducer<AuthState, LoadUserAction>(_loadUser),
  TypedReducer<AuthState, LoadUserSuccessAction>(_loadUserSuccess),
  TypedReducer<AuthState, LoadUserFailAction>(_loadUserFail),
]);

AuthState _authenticated(AuthState state, AuthenticatedAction action) =>
  state.copyWith(
    token: action.token,
  );

AuthState _loadUser(AuthState state, LoadUserAction action) =>
  state.copyWith(
    userLoading: true,
  );

AuthState _loadUserSuccess(AuthState state, LoadUserSuccessAction action) =>
  state.copyWith(
    userLoading: false,
    user: action.user,
  );

AuthState _loadUserFail(AuthState state, LoadUserFailAction action) =>
  state.copyWith(
    userLoading: false,
  );
