import 'package:flutter/material.dart';

class MapUserPointer extends StatelessWidget {
  const MapUserPointer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Container(
              height: 3,
              width: 3,
              color: Colors.white,
            ),
          ),
          Container(
            height: 15,
            width: 3,
            color: Colors.black,
          )
        ],
      )
    );
}
