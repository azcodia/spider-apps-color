import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:painting/util/api.dart';
import 'package:painting/util/validator.dart';
import 'package:painting/widget/bottom_menu.dart';
import 'package:painting/widget/input.dart';
import 'package:painting/widget/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  ContactUsPageState createState() {
    return new ContactUsPageState();
  }
}

class ContactUsPageState extends State<ContactUsPage> with ValidationMixin {
  final key = GlobalKey<ScaffoldState>();
//  final _form = GlobalKey<FormState>();
//  TextEditingController _title = new TextEditingController();
//  TextEditingController _firstName = new TextEditingController();
//  TextEditingController _lastName = new TextEditingController();
//  TextEditingController _phone = new TextEditingController();
//  TextEditingController _email = new TextEditingController();
//  TextEditingController _subject = new TextEditingController();
//  TextEditingController _message = new TextEditingController();
  bool showLoading = false;
//  Future<void> _submit() async {
//    if (_form.currentState.validate()) {
//      try {
//        var api = Api.init();
//        Response response;
//        String data = "?title=" +
//            _title.text +
//            "&firstname=" +
//            _firstName.text +
//            "&lastname=" +
//            _lastName.text +
//            "&phone=" +
//            _phone.text +
//            "&email=" +
//            _email.text +
//            "&subject=" +
//            _subject.text +
//            "&request=" +
//            _message.text;
//        setState(() {
//          showLoading = true;
//        });
//        response = await api.get("/postcontact${data}");
//        setState(() {
//          showLoading = false;
//          _title.text = "";
//          _firstName.text = "";
//          _lastName.text = "";
//          _phone.text = "";
//          _email.text = "";
//          _subject.text = "";
//          _message.text = "";
//        });
//        key.currentState.showSnackBar(SnackBar(
//          content: Text("Data Berhasil Dikirim"),
//          duration: Duration(seconds: 3),
//          action: SnackBarAction(
//            label: 'OK',
//            textColor: Colors.yellow,
//            onPressed: () {},
//          ),
//        ));
//      } on DioError catch (e) {
//        print(e.message);
//      }
//    }
//  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      key.currentState.showSnackBar(SnackBar(
        content: Text("Failed to open, please try again later."),
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
    this.getContactUsData();
  }

  @override
  void dispose() {
//    _title.dispose();
//    _firstName.dispose();
//    _lastName.dispose();
//    _phone.dispose();
//    _email.dispose();
//    _subject.dispose();
//    _message.dispose();

    super.dispose();
  }

  Future getContactUsData() async {
    try {
      var api = Api.init();
      Response response;
      response = await api.get("/contact_us");
      return response.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            key: key,
            appBar: AppBar(
              title: Text("Contact Us"),
            ),
            body: FutureBuilder(
              future: getContactUsData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Form(
//                    key: _form,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: ListView(
                        children: <Widget>[
                          Text(snapshot.data["company_name"],
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700)),
                          SizedBox(height: 8.0),
                          Text(snapshot.data["address"],
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10.0),
                          // InkWell(
                          //     onTap: () =>
                          //         _launchURL("tel:" + snapshot.data["phone_2"]),
                          //     child: Text("Phone : " + snapshot.data["phone_1"],
                          //         style: TextStyle(
                          //             fontSize: 18.0,
                          //             fontWeight: FontWeight.w400,
                          //             color: Colors.blue))),
                          SizedBox(height: 10.0),
                          InkWell(
                              onTap: () => _launchURL(
                                  "http://" + snapshot.data["website"]),
                              child: Text(snapshot.data["website"],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue))),
                          SizedBox(height: 10.0),
//                          SizedBox(
//                            width: double.infinity,
//                            height: MediaQuery.of(context).size.height / 4,
//                            child: Image.asset("assets/contactus.png"),
//                          ),
//                          SizedBox(height: 15.0),
//                          InputFormBlock("Title",
//                              controller: _title, validation: validateRequired),
//                          InputFormBlock("First Name",
//                              controller: _firstName,
//                              validation: validateRequired),
//                          InputFormBlock("Last Name",
//                              controller: _lastName,
//                              validation: validateRequired),
//                          InputFormBlock("Phone Number",
//                              controller: _phone,
//                              validation: validateRequiredNumber,
//                              isNumber: true),
//                          InputFormBlock("Email",
//                              controller: _email, validation: validateEmail),
//                          InputFormBlock("Subject",
//                              controller: _subject,
//                              validation: validateRequired),
//                          InputFormBlock("Request",
//                              controller: _message,
//                              validation: validateRequired,
//                              isTextArea: true),
                          SizedBox(height: 10.0),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 17,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
//                              child: RaisedButton(
//                                onPressed: _submit,
//                                color: Colors.red,
//                                child: Text("Submit",
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.w600,
//                                        fontSize: 20.0)),
//                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
//                          Text("*Please complete these fields")
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                } else {
                  return Loading(true);
                }
              },
            )
            // bottomNavigationBar: BottomMenu(),
            ),
        Loading(showLoading)
      ],
    );
  }
}
