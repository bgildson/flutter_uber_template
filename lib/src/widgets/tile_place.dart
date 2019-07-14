import 'package:flutter/material.dart';

enum TilePlaceType { home, company, favorite, other, }

const double kTilePaddingSize = 5;
// default sizes
const double kTileHeight = 84;
const double kIconBoxWidth = 74;
const double kIconContainerSize = 34;
const double kIconSize = 20;
// compact sizes
const double kTileHeightCompact = 64;
const double kIconBoxWidthCompact = 64;
const double kIconContainerSizeCompact = 30;
const double kIconSizeCompact = 17;

class TilePlace extends StatelessWidget {
  final TilePlaceType type;
  final String title;
  final String description;
  final bool compact;
  final VoidCallback onPressed;

  const TilePlace({
    Key key,
    @required this.title,
    this.description: '',
    TilePlaceType type,
    this.compact: false,
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
        child: Row(
          children: <Widget>[
            // icon
            Container(
              height: compact
                ? kTileHeightCompact
                : kTileHeight,
              width: compact
                ? kIconBoxWidthCompact
                : kIconBoxWidth,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 5),
              child: _buildIcon(),
            ),
            // details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: _buildDetails(),
              ),
            ),
          ],
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
      height: compact
        ? kIconContainerSizeCompact
        : kIconContainerSize,
      width: compact
        ? kIconContainerSizeCompact
        : kIconContainerSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: _iconBackground
      ),
      alignment: Alignment.center,
      child: Icon(
        _icon,
        color: Colors.white,
        size: compact
          ? kIconSizeCompact
          : kIconSize,
      ),
    );

  Widget _buildDetails() =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: compact
              ? FontWeight.w400
              : FontWeight.w500,
          ),
        ),
        description == ''
          ? Container()
          : Text(
              description,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: compact
                  ? const Color(0xFFABABAB)
                  : Colors.black,
              ),
            ),
      ],
    );
}
