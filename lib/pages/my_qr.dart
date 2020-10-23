import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yommie/class/hex_color.dart';

class MyQRPage extends StatefulWidget {
  final String username;
  final String userId;
  MyQRPage({this.username, this.userId});
  @override
  _MyQRPageState createState() => _MyQRPageState();
}

class _MyQRPageState extends State<MyQRPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 30),
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/yomiesKL.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello, ",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          "${widget.username}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 1,
                top: 1,
                child: SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              children: [
                QrImage(
                  foregroundColor: Colors.black87.withOpacity(0.7),
                  backgroundColor: Colors.white,
                  data: widget.userId,
                  version: QrVersions.auto,
                  size: 250,
                  gapless: false,
                ),
                Text(
                  widget.userId,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                SizedBox(height: 8),
                Text(
                  "Show QR Code to cashier during payments for points collection",
                  style: TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 13,
            ),
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "MY REWARDS",
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                myRewards(),
                myRewards(),
                myRewards()
              ],
            ),
          )
        ],
      ),
    );
  }

  Container myRewards() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 100,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: false,
                  imageUrl:
                      "https://yomies.com.my/pages/product/photo/yomie-bg-1-3090189656.jpg",
                  errorWidget: (context, url, error) {
                    return Image(
                      image: AssetImage("assets/images/news1.jpg"),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Birthday Reward",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[300],
                      ),
                    ),
                    Text(
                      "Redeem any of smoothies drinks at nearest store in Klang Valley",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Center(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
