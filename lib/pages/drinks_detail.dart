import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/pages/cart_page.dart';
import 'package:yommie/widget/rating_star.dart';

class DrinksDetail extends StatefulWidget {
  final String img;
  final String title;
  final String pts;
  final String ringgit;

  DrinksDetail({this.img, this.title, this.pts, this.ringgit});

  @override
  _DrinksDetailState createState() => _DrinksDetailState();
}

class _DrinksDetailState extends State<DrinksDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black45, //change your color here
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.cartPlus),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CartPage(),
                ),
              );
            },
          )
        ],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 250,
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.img), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 45,
                    child: Icon(
                      Icons.share,
                      size: 35,
                    ),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 5,
                    child: Icon(
                      Icons.favorite_border,
                      size: 35,
                    ),
                  ),
                ],
              ),
              itemProductWidget(),
              SizedBox(
                height: 80,
              )
            ],
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomWidget())
        ],
      ),
    );
  }

  GestureDetector bottomWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CartPage(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 35,
        margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Text(
              "1",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              FontAwesomeIcons.cartArrowDown,
              color: Colors.black45,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Container(
                color: Colors.red,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "ADD TO BAG",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container itemProductWidget() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[4],
        color: Colors.white,
      ),
      height: 100,
      padding: EdgeInsets.only(left: 10, top: 10, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StarRating(
                rating: double.parse("5"),
                color: Colors.red,
                size: 18,
              )
            ],
          ),
          SizedBox(height: 8),
          SizedBox(height: 8),
          Text(
            widget.pts + "pts" + " /" + " RM " + widget.ringgit,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.pink[300],
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
