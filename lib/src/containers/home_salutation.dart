import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../state/state.dart';
import '../utils/utils.dart';

class HomeSalutation extends StatelessWidget {
  const HomeSalutation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (_, vm) => 
        Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            '${parseHourToSalutation(DateTime.now().hour)}, ${vm.userName}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
    );
}

@immutable
class _ViewModel extends Equatable {
  final String userName;

  _ViewModel({this.userName}) : super([userName]);

  static _ViewModel fromStore(Store<AppState> store) =>
    _ViewModel(userName: selectAuthUserName(store.state));
}
