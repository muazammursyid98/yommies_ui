import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/models/detailsMenuModel.dart';
import 'package:yommie/models/producModels.dart';
import 'package:yommie/pages/cart_page.dart';

class DrinksPage extends StatefulWidget {
  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  List<Product> listProduct = [];
  bool loading = false;
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    var jsons = {};
    ProductModels().productPhp(jsons, context).then((value) {
      setState(() {
        listProduct = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      },
                    ),
                  )
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
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: listProduct == null ? 0 : listProduct.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: false,
                                    imageUrl:
                                        "https://yomies.com.my/pages/product/photo/${item.photo}",
                                    errorWidget: (context, url, error) {
                                      return Image(
                                        image: AssetImage(
                                            "assets/images/news1.jpg"),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                item.productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                item.point.toString() +
                                    "pts" +
                                    " / " +
                                    "RM " +
                                    item.priceNormal.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 230,
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
                              "Details ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              response["product_name"],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
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
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Receiving Points ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  response["point"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  " pts",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Divider(height: 0, thickness: 1),
              SizedBox(height: 15),
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
                        border: Border.all(color: Colors.blueAccent)),
                    child: Text(
                      response["product_code"],
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
