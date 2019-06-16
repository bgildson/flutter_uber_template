import 'package:flutter/material.dart';

const double kSearchButtonHeight = 70;

class SearchButton extends StatelessWidget {
  final VoidCallback whereButtonOnPressed;
  final VoidCallback latestButtonOnPressed;

  const SearchButton({
    Key key,
    this.whereButtonOnPressed,
    this.latestButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      height: kSearchButtonHeight,
      color: Color(0xFFEDEDED),
      child: Row(
        children: <Widget>[
          // first button
          Expanded(
            child: _buildButton(
              onPressed: whereButtonOnPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: kSearchButtonHeight,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Where to?',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            )
          ),
          // separator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Color(0xFFA3A3A3),
                    width: 1,
                  )
                )
              ),
            ),
          ),
          // second button
          _buildButton(
            onPressed: latestButtonOnPressed,
            child: Container(
              height: kSearchButtonHeight,
              width: kSearchButtonHeight,
              child: Icon(
                Icons.drive_eta,
                size: 26,
              ),
            ),
          ),
        ],
      )
    );

  _buildButton({Widget child, VoidCallback onPressed}) =>
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
}
