import 'package:flutter/material.dart';

class CoatingDefectsPage extends StatefulWidget {
  @override
  _CoatingDefectsPageState createState() => _CoatingDefectsPageState();
}

class _CoatingDefectsPageState extends State<CoatingDefectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coating Defect"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Coming Soon", style: TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}