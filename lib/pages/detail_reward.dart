import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yommie/provider/globals.dart' as globals;

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
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              height: 100,
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImage(
                    foregroundColor: Colors.black87.withOpacity(0.7),
                    backgroundColor: Colors.white,
                    data: widget.userId + ":" + widget.rewardId,
                    version: QrVersions.auto,
                    size: 250,
                    gapless: false,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Text(
            "Show QR Code to cashier during payments\nfor rewards collection",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "My Points ${globals.myPoints}",
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
    );
  }
}
