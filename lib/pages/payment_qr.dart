import 'package:flutter/material.dart';

class PaymentQR extends StatefulWidget {
  PaymentQR({Key key}) : super(key: key);

  @override
  _PaymentQRState createState() => _PaymentQRState();
}

class _PaymentQRState extends State<PaymentQR> {
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.pink[100],
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
        ],
      ),
    );
  }
}
