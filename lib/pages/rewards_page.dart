import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/models/rewardDetail.dart';
import 'package:yommie/models/rewardModels.dart';
import 'package:yommie/pages/detail_reward.dart';

class RewardPage extends StatefulWidget {
  final String userId;
  RewardPage({this.userId});

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<Reward> listRewards = [];
  List<Widget> itemList = [];
  List<Widget> itemListFreegift = [];
  List<ProductReward> listProductReward = [];
  List<FreegiftReward> listFreegift = [];

  bool loading = false;
  bool showLoading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    var jsons = {};
    RewardModels().rewardUserPhp(jsons, context).then((value) {
      setState(() {
        listRewards = value == null ? [] : value;
        loading = false;
      });
    });
    super.initState();
  }

  getMyProduct(response) {
    List product = response["product"] == null ? [] : response["product"];
    List freegift = response["freegift"] == null ? [] : response["freegift"];
    for (var u in product) {
      ProductReward item = ProductReward(
          u["id"],
          u["reward_id"],
          u["product_id"],
          u["quantity"],
          u["product_code"],
          u["product_name"],
          u["photo"]);
      listProductReward.add(item);
    }

    for (var u in freegift) {
      FreegiftReward item = FreegiftReward(
          u["id"],
          u["reward_id"],
          u["freegift"],
          u["quantity"],
          u["freegift_code"],
          u["freegift_name"],
          u["photo"]);
      listFreegift.add(item);
    }
    addListProductReward();
  }

  addListProductReward() {
    addlistProduct();
    addlistFreegift();
  }

  addlistProduct() {
    listProductReward.forEach((ProductReward item) {
      itemList.add(
        Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: false,
                    imageUrl:
                        "https://yomies.com.my/pages/reward/photo/yomie-bg-2-6441242523-8875398728.jpg",
                    errorWidget: (context, url, error) {
                      return Image(
                        image: AssetImage("assets/images/news1.jpg"),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Quantity : " + item.quantity,
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
          ],
        ),
      );
    });
  }

  addlistFreegift() {
    listFreegift.forEach((FreegiftReward item) {
      itemListFreegift.add(
        Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: false,
                    imageUrl:
                        "https://yomies.com.my/pages/reward/photo/yomie-bg-2-6441242523-8875398728.jpg",
                    errorWidget: (context, url, error) {
                      return Image(
                        image: AssetImage("assets/images/news1.jpg"),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.freegiftName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Quantity : " + item.quantity,
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
          ],
        ),
      );
    });
    setState(() {
      showLoading = false;
    });
  }

  @override
  void dispose() {
    listRewards.clear();
    itemList.clear();
    listProductReward.clear();
    itemListFreegift.clear();
    listFreegift.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
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
                        image: AssetImage("assets/images/yomiesKL.png"),
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
          child: listRewards.length != 0
              ? ListView.builder(
                  itemCount: listRewards == null ? 0 : listRewards.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listRewards[index];
                    return GestureDetector(
                      onTap: () {
                        if (!showLoading) {
                          setState(() {
                            showLoading = true;
                          });
                          itemListFreegift.clear();
                          listFreegift.clear();
                          itemList.clear();
                          listProductReward.clear();
                          var jsons = {};
                          jsons["id"] = item.id;
                          RewardDetailModel()
                              .rewardDetailPhp(jsons, context)
                              .then((value) {
                            getMyProduct(value);
                            _detailsReward(value, context);
                          });
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 25,
                            child: Text(
                              "Unlock at ${item.point} Points",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
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
                                      image:
                                          AssetImage("assets/images/news1.jpg"),
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
                              ? Container(
                                  height: 40,
                                  width: 200,
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: DetailReward(
                                              userId: widget.userId,
                                              rewardId: item.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "USED AT COUNTER",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: RaisedButton(
                                    color: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () {},
                                    child: Text(
                                      "USED",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 20),
                          Divider(height: 0, thickness: 1)
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Stay tunes upcoming rewards...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
                ),
        ),
      );
    }
  }

  void _detailsReward(response, context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: ResponsiveFlutter.of(context).verticalScale(100),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Reward".toUpperCase() + " 100 Points",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            useOldImageOnUrlChange: false,
                            imageUrl:
                                "https://yomies.com.my/pages/reward/photo/yomie-bg-2-6441242523-8875398728.jpg",
                            errorWidget: (context, url, error) {
                              return Image(
                                image: AssetImage("assets/images/news1.jpg"),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              itemList.length != 0
                  ? Text(
                      "Your rewards drinks",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey),
                    )
                  : SizedBox(),
              Column(
                children: itemList,
              ),
              SizedBox(height: 20),
              itemListFreegift.length != 0
                  ? Text(
                      "Freegift",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey),
                    )
                  : SizedBox(),
              Column(
                children: itemListFreegift,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
