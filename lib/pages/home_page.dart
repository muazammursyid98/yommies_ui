import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/Utils/locationData.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/pages/cart_page.dart';
import 'package:yommie/pages/my_qr.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFC5C5'),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.0), // here the desired height
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.only(top: 30, left: 10, right: 20),
                color: HexColor('#FFC5C5'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Loyalty Point",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 6.0,
                              percent: 0.40,
                              center: new Icon(
                                FontAwesomeIcons.chessQueen,
                                size: 18.0,
                                color: Colors.redAccent,
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.redAccent,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "1,203 pts",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(Icons.arrow_forward_ios)),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => CartPage(),
                            ),
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.cartPlus,
                          size: 30.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: HexColor('#FFC5C5'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildExpandedMenu(),
                    buildExpandedLocateUs(),
                    buildExpandedReward(),
                  ],
                ),
              ),
            )
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
          children: [
            SizedBox(
              height: 10,
            ),
            imageCarousel(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Location".toUpperCase(),
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildContainerLocation(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "product".toUpperCase(),
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildContainerProduct(),
            // SizedBox(
            //   height: 10,
            // ),
            // buildGrandOpening(context),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "event".toUpperCase(),
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildContainerEvent(),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "That's all for now!",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 40,
            ),
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
          );
        },
        child: Icon(FontAwesomeIcons.qrcode),
      ),
    );
  }

  Container buildContainerEvent() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final item = events[index];
                return Container(
                  height: double.infinity,
                  width: 130,
                  margin: EdgeInsets.only(right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item["img"]),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildGrandOpening(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      height: ResponsiveFlutter.of(context).scale(150),
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
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              itemBuilder: (context, index) {
                final item = product[index];
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: 130,
                        margin: EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(item["img"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      item["title"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
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
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: location.length,
              itemBuilder: (context, index) {
                final item = location[index];
                return Container(
                  height: double.infinity,
                  width: 130,
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(item["img"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        item["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
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

  Expanded buildExpandedReward() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => RewardPage(),
          //   ),
          // );
        },
        child: Container(
          height: 30,
          margin: EdgeInsets.only(left: 10, right: 10),
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
      ),
    );
  }

  Expanded buildExpandedLocateUs() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => DrinksPage(),
          //   ),
          // );
        },
        child: Container(
          height: 30,
          margin: EdgeInsets.only(left: 10, right: 10),
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
      ),
    );
  }

  Expanded buildExpandedMenu() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => NewsPage(),
          //   ),
          // );
        },
        child: Container(
          height: 30,
          margin: EdgeInsets.only(left: 10, right: 10),
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
      ),
    );
  }

  Container imageCarousel() {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: 230.0,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      child: CarouselSlider(
        items: [
          "assets/images/img1.jpg",
          "assets/images/event1.jpg",
          "assets/images/product1.1.jpg",
          "assets/images/grandOpening.jpg"
        ].map((i) {
          return Builder(builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                i,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
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
