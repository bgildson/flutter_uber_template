import 'package:recase/recase.dart';

import '../../entities/entities.dart';
import '../app/model.dart';
import 'model.dart';

AuthState selectAuthState(AppState state) =>
  state.auth;

bool selectAuthUserLoading(state) =>
  selectAuthState(state).userLoading;

User selectAuthUser(state) =>
  selectAuthState(state).user;

String selectAuthUserName(state) =>
  ReCase(selectAuthState(state).user.name).titleCase;

String selectAuthToken(state) =>
  selectAuthState(state).token;
