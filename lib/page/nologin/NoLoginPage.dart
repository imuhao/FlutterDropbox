import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_dropbox/AppConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class NoLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoLoginPageView();
  }
}

class NoLoginPageView extends State<NoLoginPage> {
  FlutterWebviewPlugin webViewPlugin = FlutterWebviewPlugin();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController controller = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return getLoadingWidget();
    }
    return getBodyWidget();
  }

  Widget getLoadingWidget() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Widget getBodyWidget() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 13.0, right: 13.0, top: 30.0),
            child: Text("第一次使用请输入你的AccountId."),
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "输入AccountId",
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: loginDropBox,
                child: Text("获取AccountId"),
                color: AppConfig.app_color,
                textColor: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 15.0)),
              RaisedButton(
                onPressed: bindDropBox,
                child: Text("绑定AccountId"),
                color: AppConfig.app_color,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loginDropBox() {
    Navigator.pushNamed(context, "login");
  }

  void bindDropBox() async {
    //判断是否为空
    String value = controller.text;
    if (value.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Token cannot be empty"),
            backgroundColor: AppConfig.app_color,
          ));
      return;
    }
    refreshState(true);
    String userInfo = await getList();
    print(userInfo);
    refreshState(false);
    Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(userInfo),
          backgroundColor: AppConfig.app_color,
        ));
    //保存token
    //SharedPreferences _sp = await _prefs;
    //_sp.setString(AppConfig.token_key, value);
  }

  Future<String> getUserInfo() async {
    var result = "";
    //获取用户信息
    try {
      var httpClient = HttpClient();
      var uri = Uri.http(AppConfig.base_api_url, AppConfig.get_account_path,
          {"account_id": "dbid:AAAZRnC_7P0lVZqp7brdcQHzsajqzBOcGro"});
      var request = await httpClient.postUrl(uri);

      request.headers.set("Authorization",
          "Bearer _nolaLiD2BAAAAAAAAABBMyxahyxE8VzJI3CZkf8MNC2xwt6ZHA_eibO5M_FWOoA");
      request.headers.add("Content-Type", "application/json");
      var response = await request.close();
      result = await response.transform(new Utf8Decoder().cast()).join();
      httpClient.close();
    } catch (e) {
      result = e.toString();

      print(e.toString());
    }
    return result;
  }

  Future<String> getList() async {
    var result = "";
    //获取用户信息
    try {
      var httpClient = HttpClient();
      var uri = Uri.http(AppConfig.base_api_url, AppConfig.get_list_path);
      print(uri.toString());
      var request = await httpClient.postUrl(uri);
      request.headers.set("Authorization",
          "Bearer _nolaLiD2BAAAAAAAAABBMyxahyxE8VzJI3CZkf8MNC2xwt6ZHA_eibO5M_FWOoA");
      var response = await request.close();
      result = await response.transform(new Utf8Decoder().cast()).join();
      httpClient.close();
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  void refreshState(over) {
    setState(() {
      isLoading = over;
    });
  }

  @override
  void dispose() {
    webViewPlugin.close();
    super.dispose();
  }
}
