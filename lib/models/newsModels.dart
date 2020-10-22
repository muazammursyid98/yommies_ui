import 'package:yommie/provider/rest.dart';
import 'dart:convert';

class NewsModel {
  Future<List<Ads>> adsPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "ads.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        List<Ads> adsList = [];
        for (var u in jsonResponse) {
          Ads item = Ads(
              u["ads_title"], u["description"], u["ads_date"], u["ads_photo"]);
          adsList.add(item);
        }
        return adsList;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class Ads {
  Ads(
    this.adsTitle,
    this.description,
    this.adsDate,
    this.adsPhoto,
  );

  String adsTitle;
  String description;
  String adsDate;
  String adsPhoto;
}
