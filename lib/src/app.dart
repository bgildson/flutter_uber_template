import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_prism/redux_prism.dart';

import 'pages/pages.dart';
import 'state/state.dart';

class App extends StatefulWidget {
  final Store<AppState> store;

  const App({Key key, this.store}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription _actionsSubscription;

  @override
  void initState() {
    super.initState();

    _actionsSubscription = StorePrism.actions.listen((action) {
      if (action is AuthenticatedAction) {
        _navigatorKey.currentState
          .pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomePage()), (_) => false);
      } else if (action is UnauthenticatedAction) {
        _navigatorKey.currentState
          .pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (_) => false);
      }
    });

    widget.store.dispatch(InitializeAction());
  }

  @override
  void dispose() {
    _actionsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        routes: {
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
        },
      ),
    );
}
