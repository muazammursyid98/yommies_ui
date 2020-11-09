import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class HistoryModel {
  Future purchaseHistory(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'purchases-history-list.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        return [];
      }
    } catch (e) {}
  }

  Future rewardHistory(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'reward-history-list.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
  }

  Future userHistoryByDate(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "user-history-filter.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
  }
}

class PurchasesHistory {
  PurchasesHistory(
    this.id,
    this.totalPaid,
    this.totalPoint,
    this.dateAdded,
    this.branchName,
    this.photo,
  );

  String id;
  String totalPaid;
  String totalPoint;
  String dateAdded;
  String branchName;
  String photo;
}

class RewardHistory {
  RewardHistory(
    this.redeemId,
    this.rewardId,
    this.rewardReward,
    this.rewardPoint,
    this.rewardPhoto,
    this.redeemDate,
    this.branchName,
    this.branchPhoto,
    this.status,
  );

  String redeemId;
  String rewardId;
  String rewardReward;
  String rewardPoint;
  String rewardPhoto;
  String redeemDate;
  String branchName;
  String branchPhoto;
  String status;
}
