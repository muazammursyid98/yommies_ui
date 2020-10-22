import 'package:flutter/material.dart';

class DetailReward extends StatefulWidget {
  DetailReward({Key key}) : super(key: key);

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
          color: Colors.pink[100],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
                            image: AssetImage("assets/images/logoyommie.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Hi, Wanie",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 490,
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
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 350,
                  child: Image.asset('assets/images/qrcode.png'),
                ),
                Text(
                  "MEMBER ID : 12031992",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[300],
                      fontSize: 24),
                ),
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: Text(
                    "Show QR Code to cashier during payments\nfor points collection",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "1,203 Points",
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
          Divider(
            thickness: 3,
            height: 1,
            color: Colors.grey,
          ),
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "View Benefits",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 18),
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
          ),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30, right: 30),
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(200.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 4, top: 6),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/qrcode.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Redeem Your Point",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[300],
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Redeem your point at neares Yomie's, and get a chance to get our special menu",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
