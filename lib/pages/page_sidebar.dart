import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';
import 'package:painting/widget/loading.dart';
import 'package:flutter_html/flutter_html.dart';
class PageSideBar extends StatefulWidget {
  String title,url;
  PageSideBar(this.title,this.url);
  @override
  PageSideBarState createState() {
    return new PageSideBarState();
  }
}

class PageSideBarState extends State<PageSideBar> {
  bool showLoading = true;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    this.getData();
  }

  void getData() async {
    try {
      var api = Api.init();
      Response response = await api.get(this.widget.url);
      setState(() {
        showLoading = false;
        data = response.data;
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 30.0),
            children: <Widget>[
              Html(data: data.length == 0 ? "": data["content"]),
            ],
          ),
          Loading(showLoading)
        ],
      ),
    );
  }
}
