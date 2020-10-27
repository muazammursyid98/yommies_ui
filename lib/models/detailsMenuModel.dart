import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class DetailsMenuModel {
  Future productDetailPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "product-detail.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      }
    } catch (e) {}
  }
}
