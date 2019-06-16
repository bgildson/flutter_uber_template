import 'package:flutter/material.dart';

const double kSearchButtonHeight = 56;

class SearchButton extends StatelessWidget {
  final VoidCallback whereToButtonOnPressed;
  final VoidCallback scheduleButtonOnPressed;

  const SearchButton({
    Key key,
    @required this.whereToButtonOnPressed,
    @required this.scheduleButtonOnPressed,
  }) :
    assert(whereToButtonOnPressed != null),
    assert(scheduleButtonOnPressed != null),
    super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      height: kSearchButtonHeight,
      color: Color(0xFFEDEDED),
      child: Row(
        children: <Widget>[
          // where to button
          Expanded(
            child: _buildButton(
              onPressed: whereToButtonOnPressed,
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
            ),
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
                  ),
                ),
              ),
            ),
          ),
          // schedule button
          _buildButton(
            onPressed: scheduleButtonOnPressed,
            child: Container(
              height: kSearchButtonHeight,
              width: kSearchButtonHeight,
              child: Icon(
                Icons.schedule,
                size: 26,
              ),
            ),
          ),
        ],
      ),
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
