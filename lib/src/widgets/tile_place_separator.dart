import 'package:flutter/material.dart';

import 'tile_place.dart';

class TilePlaceSeparator extends StatelessWidget {
  final bool compact;

  const TilePlaceSeparator({
    Key key,
    this.compact: false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: compact
          ? double.infinity
          : MediaQuery.of(context).size.width - kIconBoxWidth,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xFFEDEDED),
            ),
          ),
        ),
      ),
    );
}
