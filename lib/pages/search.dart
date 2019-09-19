import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painting/pages/colors_group.dart';
import 'package:painting/pages/menu.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/validator.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/select_input.dart';

import 'me_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with ValidationMixin {
  final key = GlobalKey<FormState>();
  Map<String, int> dataManufacture = {};
  Map<String, Map<String, int>> dataModel = {};
  Map<String, String> dataYear = {};
  Map<String, int> dataColor = {};

  String manufactureAnswer;
  String modelAnswer;
  String yearAnswer;
  String colorsAnswer;

  void goTo() {
    if(manufactureAnswer == null){
      _showDialog();
    }else{
      Map<String, String> whereData = {
        "brand_id": dataManufacture[manufactureAnswer].toString(),
        "type_id": dataManufacture[manufactureAnswer] == null
            ? null
            : dataModel[manufactureAnswer][modelAnswer].toString(),
        "year": dataYear[yearAnswer].toString(),
        "color_id": dataColor[colorsAnswer].toString(),
      };
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => ColorsGroupPage(whereData)));

    }
    
//    Map<String, String> whereData = {
//      "brand_id": dataManufacture[manufactureAnswer].toString(),
//      "type_id": dataManufacture[manufactureAnswer] == null
//          ? null
//          : dataModel[manufactureAnswer][modelAnswer].toString(),
//      "year": dataYear[yearAnswer].toString(),
//      "color_id": dataColor[colorsAnswer].toString(),
//    };
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (ctx) => ColorsGroupPage(whereData)));
  }

  void getDataManufacture() async {
    try {
      var api = Api.init();
      Response response;
      response = await api.get("/getbrand");
      Map<String, int> tempManufacture = {};
      Map<String, Map<String, int>> tempModel = {};
      for (var i in response.data) {
        tempManufacture.putIfAbsent(i['name'], () => i['id']);
        Map<String, int> tempModel2 = {};
        tempModel2['All Models'] = null;
        for (var j in i['get_type']) {
          tempModel2.putIfAbsent(j['name'], () => j['id']);
        }
        tempModel.putIfAbsent(i['name'], () => tempModel2);
      }

      setState(() {
        dataManufacture.clear();
        dataManufacture['All Manufactures'] = null;
        dataManufacture.addAll(tempManufacture);

        dataModel.clear();
        dataModel.addAll(tempModel);
      });
    } on DioError catch (e) {
      print(e);
    }
  }
  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          content: new Text("Mohon Pilih Manufacture"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//  void getDataYear() async {
//    try {
//      var api = Api.init();
//      Response response;
//      response = await api.get("/getyear");
//      Map<String, String> tempYear = {};
//      print(response.data);
//      for (var i in response.data) {
//        tempYear.putIfAbsent(i['year'].toString(), () => i['year'].toString());
//      }
//      setState(() {
//        dataYear.clear();
//        dataYear['All Years'] = null;
//        dataYear.addAll(tempYear);
//      });
//    } on DioError catch (e) {
//      print(e);
//    }
//  }

  void getDataColor() async {
    try {
      var api = Api.init();
      Response response;
      response = await api.get("/getcolor");
      Map<String, int> tempColor = {};
      for (var i in response.data) {
        tempColor.putIfAbsent(i['name'], () => i['id']);
      }
      setState(() {
        dataColor.clear();
        dataColor['All Colors'] = null;
        dataColor.addAll(tempColor);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getDataManufacture();
//    this.getDataYear();
    this.getDataColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        onPressed: ()=> Navigator.pop(context),),
        title: Text("Color Search"),
      ),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              SelectInput(manufactureAnswer, dataManufacture.keys.toList(),
                  'Select Manufacture', onChanged: (v) {
                setState(() {
                  manufactureAnswer = v;
                  modelAnswer = null;
                });
              }, validate: validateRequired),
              SelectInput(
                  modelAnswer,
                  manufactureAnswer != null && dataManufacture[manufactureAnswer] != null
                      ? dataModel[manufactureAnswer].keys.toList() : null,
                  'All Models', onChanged: (v) {
                setState(() {
                  modelAnswer = v;
                });
              }, validate: validateRequired),
//              SelectInput(yearAnswer, dataYear.keys.toList(), 'All Years',
//                  onChanged: (v) {
//                setState(() {
//                  yearAnswer = v;
//                });
//              }, validate: validateRequired),
              SelectInput(colorsAnswer, dataColor.keys.toList(), 'All Colors',
                  onChanged: (v) {
                setState(() {
                  colorsAnswer = v;
                });
              }, validate: validateRequired),
              SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 17,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: RaisedButton(
                    onPressed: goTo,
                    color: Colors.red,
                    child: Text("Search",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomMenu(),
    );
  }
}
