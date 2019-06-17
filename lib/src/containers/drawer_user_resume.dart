import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:recase/recase.dart';
import 'package:redux/redux.dart';

import '../entities/entities.dart';
import '../state/state.dart';
import '../utils/utils.dart';

class DrawerUserResume extends StatelessWidget {
  const DrawerUserResume({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (_, vm) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFF545454),
            )
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // photo
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(vm.user.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // name and rating
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          ReCase(vm.user.name).titleCase,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Text(
                              parseRating(vm.user.rating),
                              style: TextStyle(
                                color: const Color(0xFFA3A3A3),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: const Color(0xFFA3A3A3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
}

@immutable
class _ViewModel extends Equatable {
  final User user;

  _ViewModel({this.user}) : super([user]);

  static _ViewModel fromStore(Store<AppState> store) =>
    _ViewModel(user: selectAuthUser(store.state));
}
