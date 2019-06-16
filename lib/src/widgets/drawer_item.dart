import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final String positiveText;
  final String negativeText;
  final VoidCallback onPressed;

  const DrawerItem({
    Key key,
    @required this.text,
    this.positiveText,
    this.negativeText,
    @required this.onPressed,
  }) :
      assert(text != null),
      assert(onPressed != null),
      super(key: key);

  @override
  Widget build(BuildContext context) =>
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // main text
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              // extra text's
              positiveText != null
                ? Text(
                    positiveText,
                    style: TextStyle(
                      color: const Color(0xFF619E64),
                    ),
                  )
                : Container(),
              negativeText != null
                ? Text(
                    negativeText,
                    style: TextStyle(
                      color: const Color(0xFFD16660),
                    ),
                  )
                : Container(),
            ],
          ),
        ),
      ),
    );
}
