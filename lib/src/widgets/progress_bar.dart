import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 2,
          )
        )
      ),
    );
}
