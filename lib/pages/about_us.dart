import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/uidata.dart';
import 'package:painting/widget/loading.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatefulWidget {
  @override
  AboutUsState createState() {
    return new AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  bool showLoading = true;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future getData() async {
    try {
      var api = Api.init();
      Response response = await api.get("/about");
      // setState(() {
      //   showLoading = false;
      //   data = response.data;
      // });
      return response.data;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (ctx, snapshoot) {
            if (snapshoot.hasData) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                children: <Widget>[
                  Image.network(UIData.urlAPI +
                      "/uploads/about/" +
                      snapshoot.data["image"]),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Html(
                        data: snapshoot.data.length == 0
                            ? ""
                            : snapshoot.data["descriptions"]),
                  ),
                ],
              );
            } else {
              return Loading(true);
            }
          },
        ));
  }
}
