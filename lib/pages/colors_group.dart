import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/pages/detail_color.dart';
import 'package:painting/pages/me_page.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/uidata.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/loading.dart';
import 'package:pigment/pigment.dart';

class ColorsGroupPage extends StatefulWidget {
  String titleGroup;
  Map<String, String> whereData;
  ColorsGroupPage(this.whereData, [this.titleGroup = "Color Lists"]);

  @override
  ColorsGroupPageState createState() {
    return new ColorsGroupPageState();
  }
}

class ColorsGroupPageState extends State<ColorsGroupPage> {
  List<dynamic> dataJson;
  bool showLoading = true;
  void getDataColor() async {
    try {
      var where = "";
      this.widget.whereData.forEach((k, v) {
        if (v.toString() != "null") {
          where += k.toString() + "=" + v.toString() + "&";
          // print("WWWWWWWWWWWWW $where");
        }
      });

      var api = Api.init();
      Response response;
      response = await api.get("/color-lists?" + where);
      print("RESPONSE : ");
      print(response);
      setState(() {
        dataJson = response.data;
        showLoading = false;
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getDataColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(
                widget.titleGroup == null ? "Color Lists" : widget.titleGroup),
          ),
          body: Container(
            child: dataJson != null && dataJson.length > 0
                ? ListView.builder(
                    itemBuilder: (context, i) {
                      // print(dataJson[i].length);
                      return new ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MyPage(dataJson[i]["code"])));
                        },
                        trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: Pigment.fromString(dataJson[i]["hex"]),
                          ),
                          width: 60,
                          height: 70.0,
                          child: (![null, ""]
                                  .contains(dataJson[i]["file_color_name"]))
                              ? 
                              CachedNetworkImage(
                                  imageUrl:UIData.urlAPI +
                                  "/uploads/color/" +
                                  dataJson[i]["file_color_name"],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              // new Image.network(UIData.urlAPI +
                              //     "/uploads/color/" +
                              //     dataJson[i]["file_color_name"])
                              : null,
                        ),
                        title: Text(dataJson[i]["name"]),
                        subtitle: Text(dataJson[i]["code"]),
                      );
                    },
                    itemCount: dataJson == null ? 0 : dataJson.length,
                  )
                : Center(
                    child: !showLoading
                        ? Text(
                            "Colors not Found",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic),
                          )
                        : null,
                  ),
          ),
//           bottomNavigationBar: BottomMenu(),
        ),
        Loading(showLoading)
      ],
    );
  }
}
