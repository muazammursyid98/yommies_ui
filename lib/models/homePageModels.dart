import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class HomePageModels {
  Future homepagePhp(jsons,context) async {
    try {
      var result = await GetAPI.providers(jsons, "homepage.php");
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

class DataAd {
  DataAd(
    this.adsId,
    this.adsPhoto,
  );

  String adsId;
  String adsPhoto;
}

class DataEvent {
  DataEvent(
    this.eventName,
    this.eventPhoto,
  );

  String eventName;
  String eventPhoto;
}

class DataLocation {
  DataLocation(
    this.branchId,
    this.branchName,
    this.photo,
    this.location
  );

  String branchId;
  String branchName;
  String photo;
  String location;
}

class DataProduct {
  DataProduct(
    this.productId,
    this.productName,
    this.priceNormal,
    this.photo,
  );

  String productId;
  String productName;
  String priceNormal;
  String photo;
}
