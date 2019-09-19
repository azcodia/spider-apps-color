import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
  

class ShowWebView extends StatelessWidget {

  final String url;
  final String title;
  ShowWebView(this.url,[this.title = "Browser"]);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: {
            "/": (_) => new WebviewScaffold(
               url: url,
               withJavascript: true,
            appBar: new AppBar(        
            title: new Text(this.title),
            leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=> Navigator.pop(context),),
          ),
          
        ),
        },
    );
  }
}

