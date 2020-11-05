import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/models/historyModel.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

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
  String dateFormat;

  var showFirstDate;
  var showSecondDate;
  var firstDates;
  var secondDate;
  DateTime _startDate = DateTime.now();
  String formattedDate = DateFormat('yyyy').format(DateTime.now());
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  List<DateTime> picked;

  choiceTypeHistory(type) {
    setState(() {
      loading = true;
    });
    if (type == "purchases") {
      var jsons = {};
      HistoryModel().purchaseHistory(jsons, context).then((value) {
        loopListJson(type, value);
      });
    } else {
      var jsons = {};
      HistoryModel().rewardHistory(jsons, context).then((value) {
        loopListJson(type, value);
      });
    }
  }

  loopListJson(type, value) {
    if (type == "purchases") {
      for (var u in value) {
        PurchasesHistory item = PurchasesHistory(u["id"], u["total_paid"],
            u["total_point"], u["date_added"], u["branch_name"], u["photo"]);
        listPurchaseHistory.add(item);
      }
      addToWidget("purchases");
    } else {
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
    }
  }

  addToWidget(type) {
    if (type == "purchases") {
      listPurchaseHistory.length != 0
          ? listPurchaseHistory.forEach((PurchasesHistory item) {
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                      fontSize: 14,
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
                                      fontSize: 14,
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
            })
          : listWidgetHistory.add(Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "No history today...",
                  style:
                      TextStyle(fontWeight: FontWeight.w300, letterSpacing: 3),
                ),
              ],
            ));
      setState(() {
        loading = false;
      });
    } else {
      listRewardHistory.length != 0
          ? listRewardHistory.forEach((RewardHistory item) {
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
            })
          : listWidgetHistory.add(Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "No history today...",
                  style:
                      TextStyle(fontWeight: FontWeight.w300, letterSpacing: 3),
                ),
              ],
            ));
      setState(() {
        loading = false;
      });
    }
  }

  datePicker() async {
    picked = await DateRagePicker.showDatePicker(
        context: context,
        locale: const Locale('en', 'EN'),
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(int.parse(formattedDate) - 5),
        lastDate: new DateTime(int.parse(formattedDate) + 1));
    if (picked != null) {
      listWidgetHistory.clear();
      listRewardWidgetHistory.clear();
      listRewardHistory.clear();
      listPurchaseHistory.clear();
      if (picked.length == 1) {
        setState(() {
          dateFormat = null;
          loading = true;
          firstDates = new DateFormat("yyyy-MM-dd").format(picked[0]);
          secondDate = new DateFormat("yyyy-MM-dd").format(picked[0]);

          //for show to user
          showFirstDate = new DateFormat("dd/MM").format(picked[0]);
          showSecondDate = new DateFormat("dd/MM").format(picked[0]);
        });
        var jsons = {};
        jsons["start_date"] = firstDates;
        jsons["end_date"] = secondDate;
        jsons["type"] = dataPick.toLowerCase().trim();
        HistoryModel().userHistoryByDate(jsons, context).then((value) {
          if (value.length != 0) {
            loopListJson(dataPick.toLowerCase().trim(), value);
          } else {
            listWidgetHistory.add(
              Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "No history found...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
                ],
              ),
            );
            setState(() {
              loading = false;
            });
          }
        });
      } else if (picked.length == 2) {
        setState(() {
          dateFormat = null;
          loading = true;
          firstDates = new DateFormat("yyyy-MM-dd").format(picked[0]);
          secondDate = new DateFormat("yyyy-MM-dd").format(picked[1]);
          //for show to user
          showFirstDate = new DateFormat("dd/MM").format(picked[0]);
          showSecondDate = new DateFormat("dd/MM").format(picked[1]);
        });
        var jsons = {};
        jsons["start_date"] = firstDates;
        jsons["end_date"] = secondDate;
        jsons["type"] = dataPick.toLowerCase().trim();
        HistoryModel().userHistoryByDate(jsons, context).then((value) {
          if (value.length != 0) {
            loopListJson(dataPick.toLowerCase().trim(), value);
          } else {
            listWidgetHistory.add(
              Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "No history found...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
                ],
              ),
            );
            setState(() {
              loading = false;
            });
          }
        });
      }
    }
  }

  @override
  void initState() {
    dataPick = '  Purchases';
    dateFormat = DateFormat('dd/MM').format(DateTime.now());
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 0),
                width: 250,
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
                  items:
                      <String>['  Redeem', '  Purchases'].map((String value) {
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    datePicker();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8, right: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dateFormat != null
                              ? dateFormat
                              : showFirstDate + " - " + showSecondDate,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: dateFormat != null ? 15 : 10),
                        ),
                        Icon(
                          FontAwesomeIcons.calendarAlt,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
