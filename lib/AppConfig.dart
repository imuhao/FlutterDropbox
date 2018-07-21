import 'package:flutter/material.dart';

class AppConfig {
  static Color app_color = Color.fromARGB(255, 49, 111, 240);

  static bool is_login = false;
  static String client_id = "jw5h1ygudbirtrt";

  static String base_url = "dropbox.com";
  static String base_api_url = "api.dropboxapi.com";

  //获取token
  static String authorize_url =
      "$base_url/oauth2/authorize?response_type=code&client_id=$client_id";

  //获取用户帐号信息
  static String get_account_url = "https://$base_api_url$get_account_path";
  static String get_account_path = "/2/users/get_account";
  static String token_key = "user_token";

  //list文件
  static String get_list_path = "/2/file_requests/list";
}
