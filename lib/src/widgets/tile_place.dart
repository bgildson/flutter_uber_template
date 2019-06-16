import 'package:flutter/material.dart';

enum TilePlaceType { home, company, favorite, other, }

const double kTilePaddingSize = 5;
const double kIconBoxPaddingSize = 20;
const double kIconContainerSize = 34;
const double kIconSize = 20;
const double kTileHeight = kIconContainerSize + kIconBoxPaddingSize + kTilePaddingSize;

class TilePlace extends StatelessWidget {
  final TilePlaceType type;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const TilePlace({
    Key key,
    @required this.title,
    @required this.description,
    TilePlaceType type,
    @required this.onPressed,
  })
    : assert(title != null),
      assert(description != null),
      assert(onPressed != null),
      this.type = type ?? TilePlaceType.other,
      super(key: key);

  @override
  Widget build(BuildContext context) =>
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(kTilePaddingSize),
          child: Row(
            children: <Widget>[
              // icon
              Padding(
                padding: const EdgeInsets.all(kIconBoxPaddingSize),
                child: _buildIcon(),
              ),
              // details
              Expanded(
                child: _buildDetails(),
              ),
            ],
          ),
        ),
      ),
    );

  IconData get _icon {
    switch (type) {
      case TilePlaceType.home:
        return Icons.home;
      case TilePlaceType.company:
        return Icons.work;
      case TilePlaceType.favorite:
        return Icons.star;
      default:
        return Icons.place;
    }
  }

  Color get _iconBackground {
    switch (type) {
      case TilePlaceType.company:
        return Color(0xFF5D90F1);
      case TilePlaceType.home:
      case TilePlaceType.favorite:
      case TilePlaceType.other:
      default:
        return Color(0xFFCBCBCB);
    }
  }

  Widget _buildIcon() =>
    Container(
      height: kIconContainerSize,
      width: kIconContainerSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: _iconBackground
      ),
      alignment: Alignment.center,
      child: Icon(
        _icon,
        color: Colors.white,
        size: kIconSize,
      ),
    );

  Widget _buildDetails() =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          description,
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
}