import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yommie/models/locationModel.dart';

class LocateUs extends StatefulWidget {
  @override
  _LocateUsState createState() => _LocateUsState();
}

class _LocateUsState extends State<LocateUs> {
  List<Location> listLocation = [];

  @override
  void initState() {
    var jsons = {};
    LocationModel().locationPhp(jsons, context).then((value) {
      setState(() {
        listLocation = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(width: 15),
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Locate Us".toUpperCase(),
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
        padding: EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView.builder(
          itemCount: listLocation == null ? 0 : listLocation.length,
          itemBuilder: (BuildContext context, int index) {
            final item = listLocation[index];
            return Container(
              height: 450,
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
                              height: 250,
                              margin: EdgeInsets.all(3),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  useOldImageOnUrlChange: false,
                                  imageUrl:
                                      "https://yomies.com.my/pages/location/photo/${item.photo}",
                                  errorWidget: (context, url, error) {
                                    return Image(
                                      image:
                                          AssetImage("assets/images/news1.jpg"),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      item.branchName.replaceAll('&#39;', '’'),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      item.address,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        final url = item.googleMap;
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
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
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
