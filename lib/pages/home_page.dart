import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/Utils/locationData.dart';
import 'package:yommie/pages/drinks_page.dart';
import 'package:yommie/pages/news_page.dart';
import 'package:yommie/pages/rewards_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  final _controller2 = ScrollController();
  final _controller3 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0), // here the desired height
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.only(top: 30, left: 10, right: 20),
              color: Colors.pink[200],
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
                    child: Icon(
                      FontAwesomeIcons.cartPlus,
                      size: 30.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.pink[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => NewsPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Text(
                            "What's News",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => DrinksPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Text(
                            "Drinks",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => RewardPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Text(
                            "Reward",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
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
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img1.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
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
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: double.infinity,
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
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
                                      fit: BoxFit.fitWidth,
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
            ),
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
            Container(
              padding: EdgeInsets.only(left: 20),
              width: double.infinity,
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller2,
                      scrollDirection: Axis.horizontal,
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        final item = product[index];
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
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text("3 JULY 2020"),
                          SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              "MONT KIARA",
                              style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(3),
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: ResponsiveFlutter.of(context).scale(30),
                              width: ResponsiveFlutter.of(context)
                                  .verticalScale(150),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage(),
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
            ),
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
            Container(
              padding: EdgeInsets.only(left: 20),
              width: double.infinity,
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller3,
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
                  // IconButton(
                  //   icon: Icon(Icons.arrow_forward_ios),
                  //   onPressed: () {
                  //     Timer(
                  //       Duration(seconds: 1),
                  //       () => _controller3
                  //           .jumpTo(_controller3.position.maxScrollExtent),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
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
    );
  }
}
