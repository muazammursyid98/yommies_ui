import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class LocationModel {
  Future<List<Location>> locationPhp(jsons, context) async {
    try {
      var value = await GetAPI.providers(jsons, 'location.php');
      var statusCode = value[0];
      var response = value[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        List<Location> listLocation = [];
        for (var u in jsonResponse) {
          Location item = Location(u["branch_id"], u["branch_name"], u["address"],
              u["photo"], u["google_map"]);
          listLocation.add(item);
        }
        return listLocation;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

class Location {
  Location(
    this.branchId,
    this.branchName,
    this.address,
    this.photo,
    this.googleMap,
  );

  String branchId;
  String branchName;
  String address;
  String photo;
  String googleMap;
}
