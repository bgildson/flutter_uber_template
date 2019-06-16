import 'package:redux/redux.dart';

import 'actions.dart';
import 'model.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, InitializeAction>(_initialize),
]);

AppState _initialize(AppState state, InitializeAction action) {
  return state;
}
