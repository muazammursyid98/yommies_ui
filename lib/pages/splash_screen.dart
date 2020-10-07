import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yommie/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  removeScreen() {
    return _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    removeScreen();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/logo.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
