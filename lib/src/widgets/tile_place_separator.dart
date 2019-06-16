import 'package:flutter/material.dart';

import 'tile_place.dart';

class TilePlaceSeparator extends StatelessWidget {
  const TilePlaceSeparator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width - (kIconBoxPaddingSize * 2 + kIconContainerSize),
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
