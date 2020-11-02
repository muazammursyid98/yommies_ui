import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/models/historyModel.dart';
import 'package:yommie/pages/past_order.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<PurchasesHistory> listPurchaseHistory = [];
  List<Widget> listWidgetHistory = [];

  List<RewardHistory> listRewardHistory = [];
  List<Widget> listRewardWidgetHistory = [];

  bool loading = false;
  String dataPick;

  choiceTypeHistory(type) {
    setState(() {
      loading = true;
    });
    if (type == "purchases") {
      var jsons = {};
      HistoryModel().purchaseHistory(jsons, context).then((value) {
        for (var u in value) {
          PurchasesHistory item = PurchasesHistory(u["id"], u["total_paid"],
              u["total_point"], u["date_added"], u["branch_name"], u["photo"]);
          listPurchaseHistory.add(item);
        }
        addToWidget("purchases");
      });
    } else {
      var jsons = {};
      HistoryModel().rewardHistory(jsons, context).then((value) {
        for (var u in value) {
          RewardHistory item = RewardHistory(
              u["redeem_id"],
              u["reward_id"],
              u["reward_reward"],
              u["reward_point"],
              u["reward_photo"],
              u["redeem_date"],
              u["branch_name"],
              u["branch_photo"],
              u["status"]);
          listRewardHistory.add(item);
        }
        addToWidget("reward");
      });
    }
  }

  addToWidget(type) {
    if (type == "purchases") {
      listPurchaseHistory.forEach((PurchasesHistory item) {
        listWidgetHistory.add(Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: double.infinity,
                        width: ResponsiveFlutter.of(context).scale(200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Branch " + item.branchName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Payment"),
                            Text(item.dateAdded),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "-RM" + item.totalPaid,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "+" + item.totalPoint + "pts",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
      });
      setState(() {
        loading = false;
      });
    } else {
      listRewardHistory.forEach((RewardHistory item) {
        listWidgetHistory.add(Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: double.infinity,
                        width: ResponsiveFlutter.of(context).scale(200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Branch " + item.branchName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(item.rewardReward),
                            Text(item.redeemDate),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "-" + item.rewardPoint + "pts",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    choiceTypeHistory("purchases");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: DropdownButton<String>(
              underline: SizedBox(),
              value: dataPick,
              focusColor: Colors.black,
              iconDisabledColor: Colors.black,
              iconEnabledColor: Colors.black,
              isExpanded: true,
              style: TextStyle(color: Colors.black),
              dropdownColor: Theme.of(context).primaryColor,
              hint: Text(
                "  Select type history",
                style: TextStyle(color: Colors.black),
              ),
              items: <String>['  Redeem', '  Purchases'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                listWidgetHistory.clear();
                listRewardWidgetHistory.clear();
                listRewardHistory.clear();
                listPurchaseHistory.clear();
                setState(() {
                  dataPick = value;
                });
                choiceTypeHistory(value.toLowerCase().trim());
              },
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: listWidgetHistory,
          ),
          SizedBox(height: 180)
        ],
      );
    }
  }
}
