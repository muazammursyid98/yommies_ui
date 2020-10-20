import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:yommie/provider/globals.dart' as globals;

class GetAPI {
  static setupHTTPHeader(token) {
    globals.headers = {
      'Content-Type': 'application/json',
      'X-Authorization': 'Bearer $token',
    };
  }

  static providers(jsons, phpFile) async {
    String api = 'https://yomies.com.my/yomiesAPI/api/';
    jsons["authKey"] = "key123";
    String jsonBody = json.encode(jsons);
    print("$jsons, $phpFile");
    try {
      String url = '$api$phpFile';
      Response response =
          await post(url, headers: globals.headers, body: jsonBody);
      return [response.statusCode, response.body];
    } catch (e) {
      print(e);
      return e;
    }
  }
}
