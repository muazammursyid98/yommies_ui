import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class PastOrder extends StatefulWidget {
  PastOrder({Key key}) : super(key: key);

  @override
  _PastOrderState createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: ResponsiveFlutter.of(context).scale(250),
              width: double.infinity,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/event3.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 2,
                    left: 1,
                    child: SafeArea(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: SafeArea(
                      child: Text(
                        "SRI PETALING",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            letterSpacing: 0.5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 3,
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            margin: EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("1x The Red Tropical"),
                      Spacer(),
                      Text("RM 12.50"),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("1x Haw Purple Rice Yohurt"),
                      Spacer(),
                      Text("RM 5.50"),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("Total"),
                      Spacer(),
                      Text("RM 18.00"),
                      SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
