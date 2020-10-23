import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class RewardDetailModel {
  Future rewardDetailPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "reward-detail.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class ProductReward {
  ProductReward(
    this.id,
    this.rewardId,
    this.productId,
    this.quantity,
    this.productCode,
    this.productName,
    this.photo,
  );

  String id;
  String rewardId;
  String productId;
  String quantity;
  String productCode;
  String productName;
  String photo;
}

class FreegiftReward {
  FreegiftReward(
    this.id,
    this.rewardId,
    this.freegift,
    this.quantity,
    this.freegiftCode,
    this.freegiftName,
    this.photo,
  );

  String id;
  String rewardId;
  String freegift;
  String quantity;
  String freegiftCode;
  String freegiftName;
  String photo;
}
