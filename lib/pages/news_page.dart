import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yommie/models/newsModels.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    listAds.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    "What's News".toUpperCase(),
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
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: listAds.length != 0
              ? ListView.builder(
                  itemCount: listAds == null ? 0 : listAds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listAds[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                          height: 360,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              useOldImageOnUrlChange: false,
                              imageUrl:
                                  "https://yomies.com.my/pages/ads/photo/${item.adsPhoto}",
                              errorWidget: (context, url, error) {
                                return Image(
                                  image: AssetImage("assets/images/news1.jpg"),
                                );
                              },
                            ),

                            // Image(
                            //   image: AssetImage("assets/images/news1.jpg"),
                            // ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                          height: 90,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.description == null
                                    ? ""
                                    : item.description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                item.adsDate,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                item.adsTitle,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Stay tunes upcoming news...",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3
                    ),
                  ),
                ),
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
