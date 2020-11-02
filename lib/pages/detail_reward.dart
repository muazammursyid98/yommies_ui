import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailReward extends StatefulWidget {
  final String userId;
  final String rewardId;
  DetailReward({this.userId, this.rewardId});

  @override
  _DetailRewardState createState() => _DetailRewardState();
}

class _DetailRewardState extends State<DetailReward> {
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
              SafeArea(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 28,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: Column(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            QrImage(
              foregroundColor: Colors.black87.withOpacity(0.7),
              backgroundColor: Colors.white,
              data: widget.userId + ":" + widget.rewardId,
              version: QrVersions.auto,
              size: 250,
              gapless: false,
            ),
            Text(
              "MEMBER ID : " + widget.userId,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[300],
                  fontSize: 24),
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              "Show QR Code to cashier during payments\nfor points collection",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Current Points 1,203",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[300],
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
