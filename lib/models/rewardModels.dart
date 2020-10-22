import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class RewardModels {
  Future<List<Reward>> rewardUserPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "reward-user.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        List<Reward> listRewards = [];
        for (var u in jsonResponse) {
          Reward item = Reward(
              u["user_id"],
              u["id"],
              u["reward"],
              u["sub_title"],
              u["tnc"],
              u["point"],
              u["photo"],
              u["start_date"],
              u["end_date"],
              u["status"]);
          listRewards.add(item);
        }
        return listRewards;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class Reward {
  Reward(
    this.userId,
    this.id,
    this.reward,
    this.subTitle,
    this.tnc,
    this.point,
    this.photo,
    this.startDate,
    this.endDate,
    this.status,
  );

  String userId;
  String id;
  String reward;
  String subTitle;
  String tnc;
  String point;
  String photo;
  String startDate;
  String endDate;
  String status;
}
