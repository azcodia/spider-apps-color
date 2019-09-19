import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';

import 'package:painting/widget/loading.dart';

class MyPage extends StatefulWidget {
  final String colorId;
  final bool isQR;
  MyPage(this.colorId, {this.isQR = false});
  @override
  MyPageState createState() {
    return new MyPageState();
  }
}

class MyPageState extends State<MyPage> {
  var mapFormula =[];
  var mapFormula1 =[];
  var mapFormula2 =[];
  var countFormula = 0;
  var detail;
  List<String> indexMapFormula1;
  String colorName = "";
  String colorCode = "";
  bool showLoading = true;

  void getDataFormula() async {
   try {
     var api = Api.init();
     Response response; 
     if (widget.isQR) {
       response = await api.post("/scan-qr", data: {
          "content": this.widget.colorId,
        });
        print("RESPONSE : ");
        print(response);
     }else {
        // response = await api.get("/color-formulas/" + "Z.Q.Z");
        response = await api.get("/color-formulas/" + this.widget.colorId);
      }
      setState(() {
        this.colorCode = response.data["color"]["code"];
        this.colorName = response.data["color"]["name"];
        if(response.data["count_color_formula"] == 1) 
        {
          mapFormula = response.data["color_formula"]; 
          countFormula = response.data["count_color_formula"];
        }
        else if(response.data["count_color_formula"] == 2) 
        {
          mapFormula1 = [response.data["color_formula"]["1"]];
          mapFormula2 = [response.data["color_formula"]["2"]];
          countFormula = response.data["count_color_formula"];
        }
      });
   }on DioError catch (e) {
     print(e);
   }
  }


  @override
  void initState() {
    super.initState();
    this.getDataFormula();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> data;
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(

            // title: Text("Color Formula ( " + this.colorCode + " )"),
            // title: Text("Color Formula ( " + this.colorCode + " )"),
            title: Text((this.colorName) + " | " + (this.colorCode) + " | "),
          ),
          body: new Container(
            child: mapFormula != null && countFormula < 2
                ? new ListView.builder(
                    padding: EdgeInsets.all(5.0),
                    itemCount:
                        mapFormula == null ? 0 : mapFormula.length,
                    itemBuilder: (ctx, i) {
                      String titleName = "Formula";
                      return Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          ExpansionTile(
                            key: PageStorageKey<String>(titleName),
                            title: Text(titleName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            children: <Widget>[
                              // Text(
                              //   // this.colorName+" ( "+ this.colorCode+" )",
                              //   this.colorName+" ( "+ this.colorCode+" )",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 25.0,
                              //   ),
                              // ),
                              new Column(
                                children: <Widget>[
                                  new Table(
                                    children: [
                                      new TableRow(children: [
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                          ),
                                        )
                                      ])
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                  child: getWg(mapFormula))
                            ],
                          ),
                          Divider(
                            height: 1.0,
                          ),
                        ],
                      );
                    },
                  )
                : 
                new ListView.builder(
                    padding: EdgeInsets.all(5.0),
                    itemCount:
                        mapFormula1 == null ? 0 : mapFormula1.length,
                    itemBuilder: (ctx, i) {
                      String titleName1 = "Undercoat";
                      String titleName2 = "Topcoat";
                      return Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ExpansionTile(
                            key: PageStorageKey<String>(titleName1),
                            title: Text(titleName1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            children: <Widget>[
                              // Text(
                              //   this.colorName+" ( "+ this.colorCode1+" )",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 25.0,
                              //   ),
                              // ),
                              new Column(
                                children: <Widget>[
                                  new Table(
                                    children: [
                                      new TableRow(children: [
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                          ),
                                        )
                                      ])
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: getWg(mapFormula1))
                            ],
                          ),
                          ExpansionTile(
                            key: PageStorageKey<String>(titleName2),
                            title: Text(titleName2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            children: <Widget>[
                              // Text(
                              //   this.colorName+" ( "+ this.colorCode1+" )",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 25.0,
                              //   ),
                              // ),
                              new Column(
                                children: <Widget>[
                                  new Table(
                                    children: [
                                      new TableRow(children: [
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                          ),
                                        )
                                      ])
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: getWg(mapFormula2))
                            ],
                          ),
                          Divider(
                            height: 1.0,
                          ),
                        ],
                      );
                    },
                  ),
          ),
          // bottomNavigationBar: BottomMenu(),
        ),
        // Loading(showLoading)
      ],
    );
  }
}

TableRow createRow(List<String> cells) {
  return TableRow(children: [
    TableCell(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children:
              cells.map((String w) => Expanded(child: new Text(w))).toList(),
        ),
      ),
    )
  ]);
}

List<dynamic> generateTable(List<dynamic> data) {
  List<TableRow> dataRow = new List<TableRow>();
  dataRow.add(createRow(["Base", "Amount", "Cumulative", "Unit"]));
  num a = 0;

  for(var datas in data){
    print("DATAS : ");
    print(datas[1]);
    for(var data2 in datas){
      print(data2["percentage"].runtimeType);
      // a += num.parse(data3);
      // var round = num.parse(data2["percentage"]);
      // var parsing = round.toStringAsFixed(2);
      var unit ="gr";
      a += data2["percentage"];
      dataRow.add(createRow([
        data2["get_component"]['name'],
        data2["percentage"].toString(),
        a.toStringAsFixed(2),
        unit
      ]));
      print(data2.length);
    }
  }
  return dataRow;
}

class getWg extends StatelessWidget {
  List<dynamic> data;
  getWg(this.data);
  @override
  Widget build(BuildContext context) {
    List<Widget> tes = new List<Widget>();
    tes.add(new Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: new Table(
            border: TableBorder.all(width: 1, color: Colors.black),
            children: generateTable(data),
          ),
        ),
      ],
    ));

    return Column(
      children: tes,
    );
  }
}
