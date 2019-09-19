import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool canBack = false;
  CustomAppBar(this.canBack);

  final preferredSize = new Size.fromHeight(164.0);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Container(
            width: 120.0,
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset("assets/logoabc.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}