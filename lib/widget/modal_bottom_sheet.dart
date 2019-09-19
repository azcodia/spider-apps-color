import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> with SingleTickerProviderStateMixin {
  final email = new TextEditingController();
  var heightOfModalBottomSheet = 300.0;
  bool expandOthers = false;
  bool expandFollowUs = false;
  bool expandNewsLetter = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: heightOfModalBottomSheet,
      padding: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  child: Center(child: Text("About Us", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400))),
                  onTap: (){},
                ),
              ),
              SizedBox(height: 10.0),
              InkWell(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add, color: Colors.red),
                    ),
                    Expanded(child: Text("Others", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)),
                    IconButton(
                      icon: Icon(!expandOthers ? Icons.add:Icons.remove, color: Colors.white),
                      onPressed: () {
                        print("Others");
                        setState(() {
                          heightOfModalBottomSheet = 300.0;
                          if (expandOthers) {
                            expandOthers = false;
                          }else{
                            heightOfModalBottomSheet = heightOfModalBottomSheet + 50;
                            expandOthers = true;
                            expandFollowUs = false;
                            expandNewsLetter = false;
                          }
                        });
                      },
                    )
                  ],
                )
              ),
              expandOthers ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      child: Center(child: Text("Privacy Policy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400))),
                      onTap: (){},
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    child: Center(child: Text("Terms & Conditions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400))),
                    onTap: (){},
                  ),
                ),
                ],
              ):Container(),
              InkWell(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add, color: Colors.red),
                    ),
                    Expanded(child: Text("Follow Us", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)),
                    IconButton(
                      icon: Icon(!expandFollowUs ? Icons.add:Icons.remove, color: Colors.white),
                      onPressed: () {
                        print("Follow Us");
                        setState(() {
                          heightOfModalBottomSheet = 300.0;
                          if (expandFollowUs) {
                            expandFollowUs = false;
                          }else{
                            heightOfModalBottomSheet = heightOfModalBottomSheet + 80;
                            expandFollowUs = true;
                            expandOthers = false;
                            expandNewsLetter = false;
                          }
                        });
                      },
                    )
                  ],
                )
              ),
              expandFollowUs ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Follow us online to stay up to date with our news & events:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ):Container(),
              InkWell(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add, color: Colors.red),
                    ),
                    Expanded(child: Text("News Letter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center)),
                    IconButton(
                      icon: Icon(!expandNewsLetter ? Icons.add:Icons.remove, color: Colors.white),
                      onPressed: () {
                        print("Others");
                        setState(() {
                          heightOfModalBottomSheet = 300.0;
                          if (expandNewsLetter) {
                            expandNewsLetter = false;
                          }else{
                            heightOfModalBottomSheet = heightOfModalBottomSheet + 40;
                            expandNewsLetter = true;
                            expandFollowUs = false;
                            expandOthers = false;
                          }
                        });
                      },
                    )
                  ],
                ),
                onTap: (){},
              ),
              expandNewsLetter ? Container(
                width: double.infinity,
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                // decoration: BoxDecoration(
                //   color: Colors.black38
                // ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0)),
                          color: Colors.white
                        ),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.grey,
                          child: Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              ):Container(),
              SizedBox(height: 5.0),
              Text("@2019 abcpainting All rights reserved", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.0))
            ],
          ),
        ),
      ),
    );
  }
}