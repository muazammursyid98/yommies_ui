import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yommie/pages/login_page.dart';
import 'package:yommie/pages/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  final String userId;
  SplashScreen({this.userId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  removeScreen() {
    return _timer = Timer(Duration(seconds: 3), () {
      widget.userId == null
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NavigationBar(),
              ),
            );
      ;
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
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
