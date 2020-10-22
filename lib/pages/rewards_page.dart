import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yommie/models/rewardModels.dart';
import 'package:yommie/pages/detail_reward.dart';

class RewardPage extends StatefulWidget {
  RewardPage({Key key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<Reward> listRewards = [];

  @override
  void initState() {
    var jsons = {};
    RewardModels().rewardUserPhp(jsons, context).then((value) {
      setState(() {
        listRewards = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    listRewards.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 30),
          color: Theme.of(context).primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logoyommie.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: listRewards == null ? 0 : listRewards.length,
          itemBuilder: (BuildContext context, int index) {
            final item = listRewards[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Unlock at ${item.point} Points",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: false,
                        imageUrl:
                            "https://yomies.com.my/pages/reward/photo/${item.photo}",
                        errorWidget: (context, url, error) {
                          return Image(
                            image: AssetImage("assets/images/news1.jpg"),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Free 1x drink",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Redeem any of smoothies drinks at nearest store in Klang Valley",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                item.status != "LOCK"
                    ? SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailReward(),
                              ),
                            );
                          },
                          child: Text(
                            "USED AT COUNTER",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text(
                            "USED",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
