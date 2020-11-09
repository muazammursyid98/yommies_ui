import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/class/responsive.dart';
import 'package:yommie/models/homePageModels.dart';
import 'package:yommie/pages/locateUs_page.dart';
import 'package:yommie/pages/my_qr.dart';
import 'package:yommie/pages/navigation_bar_dummy.dart';
import 'package:yommie/provider/globals.dart' as globals;

import 'navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String userId;
  HomePage({this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataAd> listAds = [];
  List<DataLocation> listLocation = [];
  List<DataProduct> listProduct = [];
  List<DataEvent> listEvent = [];
  bool loading = false;
  Timer _timer;

  String username;
  String userpoint;

  Responsive responsive;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    callApi();
    super.initState();
  }

  callApi() {
    var jsons = {};
    // jsons["userId"] = widget.userId;
    HomePageModels().homepagePhp(jsons, context).then((value) {
      final dataAds = value["data_ads"] == null ? [] : value["data_ads"];
      final dataLocation =
          value["data_location"] == null ? [] : value["data_location"];
      final dataProduct =
          value["data_product"] == null ? [] : value["data_product"];
      final dataEvent = value["data_event"] == null ? [] : value["data_event"];

      for (var u in dataAds) {
        DataAd item = DataAd(u["ads_id"], u["ads_photo"]);
        listAds.add(item);
      }

      for (var u in dataLocation) {
        DataLocation item = DataLocation(
            u["branch_id"], u["branch_name"], u["photo"], u["google_map"]);
        listLocation.add(item);
      }

      for (var u in dataProduct) {
        DataProduct item = DataProduct(
            u["product_id"], u["product_name"], u["price_normal"], u["photo"]);
        listProduct.add(item);
      }

      for (var u in dataEvent) {
        DataEvent item = DataEvent(u["event_name"], u["event_photo"]);
        listEvent.add(item);
      }

      setState(() {
        username = value["data_point"]["user_name"];
        userpoint = value["data_point"]["user_point"];
        globals.myPoints = userpoint;
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    listAds.clear();
    listLocation.clear();
    listProduct.clear();
    listEvent.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive.of(context);
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: HexColor('#FFC5C5'),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.0), // here the desired height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: responsive.hp(16),
                width: double.infinity,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          "Total Points",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$userpoint" + " pts",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: HexColor('#FFC5C5'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildExpandedMenu(),
                      SizedBox(width: 8),
                      buildExpandedReward(),
                      SizedBox(width: 8),
                      buildExpandedLocateUs(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(height: 20),
              listAds.length != 0 ? imageCarousel() : SizedBox(),
              listAds.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listLocation.length != 0 ? buildTitle("Location") : SizedBox(),
              listLocation.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listLocation.length != 0 ? buildContainerLocation() : SizedBox(),
              listLocation.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listLocation.length != 0
                  ? Divider(height: 0, thickness: 1)
                  : SizedBox(),
              listProduct.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listProduct.length != 0 ? buildTitle("Product") : SizedBox(),
              listProduct.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listProduct.length != 0 ? buildContainerProduct() : SizedBox(),
              listProduct.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listProduct.length != 0
                  ? Divider(height: 0, thickness: 1)
                  : SizedBox(),
              listEvent.length != 0
                  ? SizedBox(
                      height: 20,
                    )
                  : SizedBox(),
              listEvent.length != 0 ? buildTitle("News") : SizedBox(),
              listEvent.length != 0 ? SizedBox(height: 20) : SizedBox(),
              listEvent.length != 0 ? buildContainerEvent() : SizedBox(),
              SizedBox(height: 40),
              Center(
                child: Text(
                  "That's all for now!",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var firstname = prefs.getString('firstName');
            var userId = prefs.getString('userId');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MyQRPage(
                  username: firstname,
                  userId: userId,
                ),
              ),
            ).then((value) {
              listAds.clear();
              listLocation.clear();
              listProduct.clear();
              listEvent.clear();
              callApi();
            });
          },
          child: Icon(FontAwesomeIcons.qrcode),
        ),
      );
    }
  }

  Row buildTitle(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Spacer(),
        // Text(
        //   "Show more",
        //   style: TextStyle(
        //     color: Colors.grey,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 15,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 8),
        //   child: Icon(
        //     Icons.arrow_forward_ios,
        //     color: Colors.grey,
        //     size: 20,
        //   ),
        // ),
      ],
    );
  }

  GestureDetector buildContainerEvent() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NavigationBarDummy(
              userId: widget.userId,
              page: 1,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 11),
        width: double.infinity,
        height: responsive.dp(25),
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listEvent.length,
                itemBuilder: (context, index) {
                  final item = listEvent[index];
                  return Container(
                    height: double.infinity,
                    width: 189,
                    margin: EdgeInsets.only(right: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(0),
                                    width: double.infinity,
                                    height: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        useOldImageOnUrlChange: false,
                                        imageUrl:
                                            "https://yomies.com.my/pages/event/photo_event/${item.eventPhoto}",
                                        errorWidget: (context, url, error) {
                                          return Image(
                                            image: AssetImage(
                                                "assets/images/news1.jpg"),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      item.eventName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 25,
                                    width: 100,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: Text(
                                      "See More",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildGrandOpening(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      height: responsive.hp(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            width: 140,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/grandOpening.jpg"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GRAND OPENING",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text("3 JULY 2020"),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      "MONT KIARA",
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(3),
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: ResponsiveFlutter.of(context).scale(30),
                      width: ResponsiveFlutter.of(context).verticalScale(150),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                          );
                        },
                        child: Text("LOCATE US"),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainerProduct() {
    return Container(
      padding: EdgeInsets.only(left: 11),
      width: double.infinity,
      height: responsive.dp(25),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                final item = listProduct[index];
                return Container(
                  height: double.infinity,
                  width: 189,
                  margin: EdgeInsets.only(right: 7, left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(0),
                                  width: double.infinity,
                                  height: 110,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      useOldImageOnUrlChange: false,
                                      imageUrl:
                                          "https://yomies.com.my/pages/product/photo/${item.photo}",
                                      errorWidget: (context, url, error) {
                                        return Image(
                                          image: AssetImage(
                                              "assets/images/news1.jpg"),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: Text(
                                    item.productName,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            NavigationBarDummy(
                                          userId: widget.userId,
                                          page: 2,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: Text(
                                      "See More",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainerLocation() {
    return Container(
      padding: EdgeInsets.only(left: 11),
      width: double.infinity,
      height: responsive.dp(25),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listLocation.length,
              itemBuilder: (context, index) {
                final item = listLocation[index];
                return Container(
                  height: double.infinity,
                  width: 189,
                  margin: EdgeInsets.only(right: 7, left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(3),
                                  width: double.infinity,
                                  height: 110,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      useOldImageOnUrlChange: false,
                                      imageUrl:
                                          "https://yomies.com.my/pages/location/photo/${item.photo}",
                                      errorWidget: (context, url, error) {
                                        return Image(
                                          image: AssetImage(
                                              "assets/images/news1.jpg"),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: Text(
                                    item.branchName.replaceAll('&#39;', '’'),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    final url = item.location;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: Text(
                                      "Go Now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildExpandedReward() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NavigationBarDummy(
              userId: widget.userId,
              page: 3,
            ),
          ),
        );
      },
      child: Container(
        height: 30,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Text(
          "Reward",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  GestureDetector buildExpandedLocateUs() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LocateUs(),
          ),
        );
      },
      child: Container(
        height: 30,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Text(
          "Locate Us",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  GestureDetector buildExpandedMenu() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NavigationBar(
              userId: widget.userId,
              page: 2,
            ),
          ),
        );
      },
      child: Container(
        height: 30,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Container imageCarousel() {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: responsive.dp(26),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      child: CarouselSlider(
        items: listAds.map((DataAd i) {
          return Builder(builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                useOldImageOnUrlChange: false,
                imageUrl: "https://yomies.com.my/pages/ads/photo/" + i.adsPhoto,
                errorWidget: (context, url, error) {
                  return Image(
                    image: AssetImage("assets/images/news1.jpg"),
                  );
                },
              ),

              //  Image.network(
              //   "https://yomies.com.my/pages/ads/photo/" + i.adsPhoto,
              //   height: double.infinity,
              //   width: double.infinity,
              //   fit: BoxFit.contain,
              // ),
            );
          });
        }).toList(),
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: true,
        ),
      ),
    );
  }
}
