import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_dropbox/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageView();
  }
}

class LoginPageView extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      appBar: AppBar(
        title: Text("Login Dropbox"),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      url: AppConfig.authorize_url,
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
