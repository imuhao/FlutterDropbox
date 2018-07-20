import 'package:flutter_dropbox/AppConfig.dart';
import 'package:flutter/material.dart';
import 'nologin/NoLoginPage.dart';
import 'login/LoginPage.dart';
import 'home/HomePage.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterDropbox",
      theme: ThemeData(primaryColor: AppConfig.app_color),
      home: Scaffold(
        body: goToThatPage(),
        appBar: AppBar(
          title: Text("FlutterDropbox"),
        ),
      ),
      routes: {
        "login": (context) => LoginPage(),
      },
    );
  }

  goToThatPage() {
    if (AppConfig.is_login) {
      return HomePage();
    } else {
      return NoLoginPage();
    }
  }
}
