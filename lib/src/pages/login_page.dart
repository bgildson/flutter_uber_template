import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';

  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: Center(
        child: Text('You aren\'t authenticated!'),
      ),
    );
}
