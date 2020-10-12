import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/Utils/productData.dart';
import 'package:yommie/pages/cart_page.dart';
import 'package:yommie/pages/drinks_detail.dart';

class DrinksPage extends StatefulWidget {
  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            color: Colors.pink[100],
            child: Row(
              children: [
                // IconButton(
                //   icon: Icon(Icons.arrow_back_ios),
                //   color: Colors.black,
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    "Drinks".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.cartPlus,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CartPage(),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.pink[100],
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: productItem.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final item = productItem[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DrinksDetail(
                            title: item["title"],
                            img: item["img"],
                            pts: item["pts"],
                            ringgit: item["rm"],
                          ),
                        ),
                      );
                    },
                    child: GridTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left: 10, top: 15, right: 10, bottom: 2),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item["img"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              item["title"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              item["pts"] + "pts" + " / " + "RM " + item["rm"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
