import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/class/notification.dart';
import 'package:yommie/pages/login_page.dart';
import 'package:yommie/pages/navigation_bar.dart';
import 'package:yommie/pages/navigation_bar_dummy.dart';

class SplashScreen extends StatefulWidget {
  final String userId;
  SplashScreen({this.userId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  removeScreen() {
    return _timer = Timer(Duration(seconds: 2), () {
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
                builder: (BuildContext context) => NavigationBarDummy(
                  userId: widget.userId,
                ),
              ),
            );
    });
  }

  @override
  void initState() {
    // if (widget.userId != null) {
    //   MyNotification().unsubscribeMessage(widget.userId);
    //   MyNotification().subcribeMessage(widget.userId, context);
    // }
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
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: ResponsiveFlutter.of(context).scale(350),
          height: ResponsiveFlutter.of(context).verticalScale(350),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/yomiesLogo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
