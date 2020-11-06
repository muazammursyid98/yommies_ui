import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/class/responsive.dart';
import 'package:yommie/models/detailsMenuModel.dart';
import 'package:yommie/models/producModels.dart';
import 'package:yommie/pages/my_qr.dart';

class DrinksPage extends StatefulWidget {
  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  List<Product> listProduct = [];
  bool loading = false;
  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() {
    setState(() {
      loading = true;
    });
    var jsons = {};
    ProductModels().productPhp(jsons, context).then((value) {
      setState(() {
        listProduct = value == null ? [] : value;
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    listProduct.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(top: 30),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      "Menu".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       FontAwesomeIcons.cartPlus,
                  //       color: Colors.black54,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (BuildContext context) => CartPage(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: listProduct.length != 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: listProduct == null ? 0 : listProduct.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.5),
                        ),
                        itemBuilder: (context, index) {
                          final item = listProduct[index];
                          return GestureDetector(
                            onTap: () {
                              var jsons = {};
                              jsons["id"] = item.productId;
                              DetailsMenuModel()
                                  .productDetailPhp(jsons, context)
                                  .then((value) {
                                _detailsMenu(value, context);
                              });
                            },
                            child: GridTile(
                                child: Container(
                              height: double.infinity,
                              width: 160,
                              margin: EdgeInsets.only(right: 7, left: 8),
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
                                          border: Border.all(
                                              color: Colors.grey[300]),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    top: 15,
                                                    right: 10,
                                                    bottom: 2),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    useOldImageOnUrlChange:
                                                        false,
                                                    imageUrl:
                                                        "https://yomies.com.my/pages/product/photo/${item.photo}",
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Image(
                                                        image: AssetImage(
                                                            "assets/images/news1.jpg"),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                item.productName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "RM" + item.priceNormal,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  " or ",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  item.point + "pts",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 100,
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                              ),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        blurRadius: 1.0,
                                                        color: Colors.black
                                                            .withOpacity(0.2)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    "Stay tunes upcoming menu...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
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
            ).then((value) {
              listProduct.clear();
              callApi();
            });
          },
          child: Icon(FontAwesomeIcons.qrcode),
        ),
      );
    }
  }

  _detailsMenu(response, context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: ResponsiveFlutter.of(context).verticalScale(150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: ResponsiveFlutter.of(context).scale(160),
                      height: double.infinity,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 10, top: 15, right: 5, bottom: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            useOldImageOnUrlChange: false,
                            imageUrl:
                                "https://yomies.com.my/pages/product/photo/${response["photo"]}",
                            errorWidget: (context, url, error) {
                              return Image(
                                image: AssetImage("assets/images/news1.jpg"),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 5, top: 15, right: 10, bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              response["product_name"],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Price ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "RM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  response["price_normal"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  " or ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  response["point"].toString() + "pts",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                "Receiving Points ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Row(
                                children: [
                                  Text(
                                    response["point"].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      " pts",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 0, thickness: 1),
              SizedBox(height: 10),
              Text(
                "PRODUCT CODE",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(
                      response["product_code"],
                      style:
                          TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
