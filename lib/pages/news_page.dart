import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/class/responsive.dart';
import 'package:yommie/models/newsModels.dart';
import 'package:yommie/pages/my_qr.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Ads> listAds = [];
  bool loading = false;

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() {
    setState(() {
      loading = true;
    });
    var jsons = {};
    NewsModel().adsPhp(jsons, context).then((value) {
      setState(() {
        listAds = value == null ? [] : value;
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    listAds.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(top: 30),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "What's New".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: listAds.length != 0
              ? ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: listAds == null ? 0 : listAds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listAds[index];
                    return Container(
                      height: responsive.wp(120),
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 7, left: 7, top: 10),
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
                                      margin: EdgeInsets.only(
                                          top: 20, right: 20, left: 20),
                                      height: 360,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          useOldImageOnUrlChange: false,
                                          imageUrl:
                                              "https://yomies.com.my/pages/ads/photo/${item.adsPhoto}",
                                          errorWidget: (context, url, error) {
                                            return Image(
                                              image: AssetImage(
                                                  "assets/images/news1.jpg"),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, right: 20, left: 20),
                                      height: 90,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.adsTitle
                                                    .replaceAll('&#39;', '’'),
                                                style: TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                item.adsDate,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item.description == null
                                                ? ""
                                                : item.description,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Stay tunes upcoming news...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
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
              callApi();
            });
          },
          child: Icon(FontAwesomeIcons.qrcode),
        ),
      );
    }
  }

  Widget networkImage(adsPhoto) {
    String url = "https://yomies.com.my/pages/ads/photo/$adsPhoto";
    try {
      return CachedNetworkImage(
        useOldImageOnUrlChange: false,
        imageUrl: url,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) {
          return Image(
            image: AssetImage("assets/images/news1.jpg"),
          );
        },
      );
    } catch (e) {
      return Image(
        image: AssetImage("assets/images/news1.jpg"),
      );
    }
  }
}
