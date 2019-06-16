import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/state/app/app.dart';
import 'src/app.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    distinct: true,
    middleware: []
      ..addAll(createAllMiddlewares()),
    initialState: AppState.initial(),
  );

  runApp(App(store: store));
}
