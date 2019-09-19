import 'package:flutter/material.dart';
import 'package:painting/pages/coating_defects.dart';
import 'package:painting/pages/contact_us.dart';
import 'package:painting/pages/detail_color.dart';
import 'package:painting/pages/me_page.dart';
import 'package:painting/pages/search.dart';
import 'package:painting/pages/submit_issue.dart';
import 'package:painting/pages/webview.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/buttons.dart';
import 'package:painting/widget/custom_appbar.dart';
import 'package:painting/widget/drawer.dart';
import 'package:painting/widget/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() {
    return new MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {
  final key = GlobalKey<ScaffoldState>();
  bool showLoading = false;

  void toPage(context, page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  void initState() {
    super.initState();
  }

  void setStateLoading(bool showLoading) {
    setState(() {
      this.showLoading = showLoading;
    });
  }

  Future<String> scanQR() {
    return new QRCodeReader()
        .setAutoFocusIntervalInMs(200) // default 5000
        .setForceAutoFocus(true) // default false
        .setTorchEnabled(true) // default false
        .setHandlePermissions(true) // default true
        .setExecuteAfterPermissionGranted(true) // default true
        .scan();
  }

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      const url = 'http://abca-indonesia.com';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Stack(
      children: <Widget>[
        Scaffold(
          key: key,
          // appBar: CustomAppBar(false),
          appBar: new AppBar(
            title: ClipOval(
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(color: Colors.white),
                  child: new Image.asset("assets/app_icon.png")),
            ),
            centerTitle: true,
          ),
          drawer: SideBar(this.setStateLoading),
          body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                ButtonsMenu('Color Search', 'cari.png',
                    onPress: () => toPage(context, SearchPage())),
                ButtonsMenu('QR', 'qrcode.png', onPress: () async {
                  var code = await scanQR();
                  print(code);
                  if (code != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MyPage(
                              code,
                              isQR: true,
                            )));
                    // toPage(context,ShowWebView(code,"PT Anugerah Berkat Cahaya Abadi"));
                  }
                }),
                // ButtonsMenu('Web', 'web.png',
                //     onPress: () => toPage(
                //         context,
                //         ShowWebView("http://abca-indonesia.com",
                //             "PT Anugerah Berkat Cahaya Abadi"))),
                ButtonsMenu(
                  'web',
                  'web.png',
                  onPress: () => _launchURL(),
                ),
                ButtonsMenu(
                  'Coating Defects',
                  'coating_defects_grey.png',
                ),
                ButtonsMenu('Submit Issue', 'issue.png',
                    onPress: () => toPage(context, SubmitIssuePage())),
                ButtonsMenu('Contact Us', 'contact_us.png',
                    onPress: () => toPage(context, ContactUsPage())),
              ],
            ),
          ),
          // bottomNavigationBar: BottomMenu(),
        ),
        Loading(showLoading)
      ],
    );
  }
}
