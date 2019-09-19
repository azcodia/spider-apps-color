import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/uidata.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/loading.dart';

class CoatingDetailPage extends StatefulWidget {
  String title, id;
  CoatingDetailPage({this.title, this.id});

  @override
  CoatingDetailPageState createState() {
    return new CoatingDetailPageState();
  }
}

class CoatingDetailPageState extends State<CoatingDetailPage> {
  List<dynamic> dataJson = [];
  List<Widget> images = [];
  bool showLoading = true;
  void getData() async {
    try {
      // print(where);
      var api = Api.init();
      Response response;
      response = await api.get("/coatingdefectimages/" + this.widget.id);
      setState(() {
        dataJson = response.data;
        showLoading = false;
        print(dataJson);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            child: new ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              itemCount: dataJson.length,
              itemBuilder: (ctx, i) {
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Image.network(UIData.urlAPI +
                      "/uploads/coating-defects/" +
                      dataJson[i]["image_name"]),
                );
              },
            ),
          ),
          Loading(showLoading)
        ],
      ),
      // bottomNavigationBar: BottomMenu(),
    );
  }
}
