import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';

import 'package:painting/widget/loading.dart';

class DetailColorPage extends StatefulWidget {
  final String colorId;
  final bool isQR;
  DetailColorPage(this.colorId, {this.isQR = false});
  @override
  DetailColorPageState createState() {
    return new DetailColorPageState();
  }
}

class DetailColorPageState extends State<DetailColorPage> {

  Map<String, dynamic> mapFormula;
  List<String> indexMapFormula;
  String colorName = "";
  String colorCode= "";
  bool showLoading = true;
  List<dynamic> dataColourFormula;

  void getDataFormula() async {
    try {
      var api = Api.init();
      Response response;
      if (widget.isQR) {
        response = await api.post("/scan-qr", data: {
          "content": this.widget.colorId,
        });
        print("RESPONSE QR $response");
      } else {
        response = await api.get("/color-formulas/" + this.widget.colorId);
        print("RESPONSE GET $this.widget.colorId+1");
      }
      setState(() {
        if (response.data["count_color_formula"] == 0) {
          print("=-=====================================================");
          mapFormula = new Map<String, dynamic>();
          indexMapFormula = new List<String>();
          // dataColourFormula = new List<String>();
        } else {
          mapFormula = response.data['color_formula'];
          indexMapFormula = mapFormula.keys.toList();
          this.colorName = response.data["color"]["name"];
          this.colorCode = response.data["color"]["code"];
          // print(colorName);
        }
        showLoading = false;
        // print(mapFormula.keys.toList());
      });
    } on DioError catch (e) {
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
            title: Text("Color Formula (" + this.colorName + ")"),
          ),
          body: new Container(
            child: indexMapFormula != null && indexMapFormula.length > 0
                ? new ListView.builder(
                    padding: EdgeInsets.all(5.0),
                    itemCount:
                        indexMapFormula == null ? 0 : indexMapFormula.length,
                    itemBuilder: (ctx, i) {
                      String titleName = "Formula " + (i + 1).toString();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ExpansionTile(
                            key: PageStorageKey<String>(titleName),
                            title: Text(titleName),
                            children: <Widget>[
                              Text(
                                this.colorName+" ( "+ this.colorCode+" )",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
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
                                  child: getWg(mapFormula[indexMapFormula[i]]))
                            ],
                          ),
                          Divider(
                            height: 1.0,
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: !showLoading
                        ? Text(
                            "Color Formula not available",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic),
                          )
                        : null,
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
  for (var datas in data) { 
    var datas2 = datas["percentage"];
    a += num.parse(datas2);
    var rounding = num.parse(datas["percentage"]);
    var parsing = rounding.toStringAsFixed(2);
    dataRow.add(createRow([
      datas["get_component"]["name"],
      parsing,
      a.toStringAsFixed(2),
      datas["get_component"]["unit"]
    ]));
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
          padding: EdgeInsets.symmetric(vertical: 10.0),
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
