import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  bool show;
  Loading(this.show);

  @override
  Widget build(BuildContext context) {
    return show ? Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black26
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(25.0)
          ),
          padding: EdgeInsets.all(16.0),
          width: 120.0,
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
              Text("Loading...", style: TextStyle(color : Colors.white, fontSize: 12.0), maxLines: 1,)
            ],
          ),
        ),
      ),
    ):Container();
  }
}