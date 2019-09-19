import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/validator.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/input.dart';
import 'package:painting/widget/loading.dart';

class SubmitIssuePage extends StatefulWidget {
  @override
  SubmitIssuePageState createState() {
    return new SubmitIssuePageState();
  }
}

class SubmitIssuePageState extends State<SubmitIssuePage> with ValidationMixin {
  final key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  TextEditingController _fullName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _subject = new TextEditingController();
  TextEditingController _message = new TextEditingController();
  bool showLoading = false;
  Future<void> _submit() async {
    var txtSnackbar="";
    if (_form.currentState.validate()) {
      try {
        var api = Api.init();
        Response response;
        String data = "?fullname=" + _fullName.text + "&email=" + _email.text + "&subject=" + _subject.text + "&message=" + _message.text;
        setState(() {
          showLoading = true;
        });
        print("/submitissue${data}");
        response = await api.get("/submitissue${data}");
        setState(() {
          showLoading = false;
          _fullName.text = "";
          _email.text = "";
          _subject.text = "";
          _message.text = "";
          txtSnackbar ="Data Berhasil Dikirim";
        });
        
      } on DioError catch (e) {
        print(e.message);
        setState(() {
          txtSnackbar ="Error";
        showLoading = false;
                });
      }
      key.currentState.showSnackBar(SnackBar(
          content: Text(txtSnackbar),
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _subject.dispose();
    _message.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Submit Issue"),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _form,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: ListView(
                children: <Widget>[
                  InputFormBlock("Full Name",
                      controller: _fullName,
                      validation: validateRequired,
                      isTextArea: false),
                  InputFormBlock("Email",
                      controller: _email,
                      validation: validateEmail,
                      isTextArea: false),
                  InputFormBlock("Subject",
                      controller: _subject,
                      validation: validateRequired,
                      isTextArea: false),
                  InputFormBlock("Message",
                      controller: _message,
                      validation: validateRequired,
                      isTextArea: true),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 17,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: RaisedButton(
                        onPressed: _submit,
                        color: Colors.red,
                        child: Text("Submit",
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
          Loading(showLoading)
        ],
      ),
      // bottomNavigationBar: BottomMenu(),
    );
  }
}
