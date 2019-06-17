import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_prism/redux_prism.dart';

import 'src/state/app/app.dart';
import 'src/app.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    distinct: true,
    middleware: []
      ..addAll(createAllMiddlewares())
      ..add(StorePrism.middleware),
    initialState: AppState.initial(),
  );

  runApp(App(store: store));
}
