import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:painting/pages/about_us.dart';
import 'package:painting/pages/page_sidebar.dart';
import 'package:painting/pages/webview.dart';
import 'package:painting/util/api.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatefulWidget {
  Function setStateLoading;
  SideBar(this.setStateLoading);
  @override
  _SideBarState createState() => _SideBarState();
}

final String about = "http://abcpainting.cranium.id/about";
final String privacyPolicy = "http://abcpainting.cranium.id/privacy-policy";
final String termAndConditions =
    "http://abcpainting.cranium.id/terms-conditions";
final String facebook = "https://www.facebook.com/abcacoating/";
final String instagram = "https://www.instagram.com/abcacoating/?hl=id";

class _SideBarState extends State<SideBar> {
  final key = GlobalKey<ScaffoldState>();
  TextEditingController email = new TextEditingController();
  void toPage(context, String url, [String title = ""]) {
    if (url.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ShowWebView(url, title)));
    }
  }

  void sendSubscribe() async {
    Navigator.pop(context);
    var api = Api.init();
    Response response;

    try {
      this.widget.setStateLoading(true);
      response = await api.get('/newsletter?email=${email.text}');
      this.widget.setStateLoading(false);
      print(response.statusCode);
      print(response.data);
      String msg = response.data["status"];
      // msg = (response.data["status"] == "failed")
      //     ? "Your email has been subscribed !"
      //     : "Subscribe successful";
      showDialog(
          context: context,
          child: new AlertDialog(
            content: Text(msg),
            actions: <Widget>[
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
    } on DioError catch (e) {
      print(e);
    }
  }

  void subscribeDialog() {
    AlertDialog dialog = new AlertDialog(
        actions: <Widget>[
          RaisedButton(
            color: Colors.red,
            child: Text(
              "Send",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: sendSubscribe,
          )
        ],
        content: SizedBox(
          height: 40.0,
          child: TextField(
            controller: email,
            decoration: InputDecoration(
                hintText: "Email", suffixIcon: Icon(Icons.email)),
          ),
        ));
    showDialog(context: context, child: dialog);
  }

  Future<void> _launchURL(String link) async {
    if (await canLaunch(link)) {
      this.widget.setStateLoading(true);
      await launch(link);
      this.widget.setStateLoading(false);
    } else {
      key.currentState.showSnackBar(SnackBar(
        content: Text("Failed to open Browser, please try again later."),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.yellow,
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: new Text("About Us"),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx) => AboutUs())),
          ),
          Divider(
            height: 5.0,
          ),
          // ListTile(
          //   title: new Text("Privacy Policy"),
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (ctx) =>
          //               PageSideBar("Privacy Policy", "/privacy-policy"))),
          // ),
          Divider(
            height: 5.0,
          ),
          // ListTile(
          //   title: new Text("Terms & Conditions"),
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (ctx) =>
          //               PageSideBar("Terms & Conditions", "/terms-conditions"))),
          //   // onTap: () => toPage(context, termAndConditions, "Terms & Conditions"),
          // ),
          Divider(
            height: 5.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: new Text(
                      "Follow us online to stay up to date with our news & events : ")),
              new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _launchURL(facebook),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Icon(
                            FontAwesomeIcons.facebook,
                            size: 35.0,
                          )),
                    ),
                    InkWell(
                      onTap: () => _launchURL(instagram),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Icon(
                            FontAwesomeIcons.instagram,
                            size: 35.0,
                          )),
                    ),
                  ])
            ],
          ),
          Divider(
            height: 5.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            height: 60.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: RaisedButton(
                onPressed: () => subscribeDialog(),
                color: Colors.red,
                child: Text("Click Here For Subscribe",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
