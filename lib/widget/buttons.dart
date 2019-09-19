import 'package:flutter/material.dart';

class ButtonsMenu extends StatelessWidget {
  String imageUrl;
  String title;
  GestureTapCallback onPress;
  ButtonsMenu(this.title, this.imageUrl, {Key key, this.onPress}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 5.0, color: Colors.black26),
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: SizedBox(
                width: 60.0,
                height: 60.0,
                child: Image.asset('assets/${imageUrl}')
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(title)
            )
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}