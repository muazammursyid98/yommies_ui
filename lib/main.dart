import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yommie/pages/splash_screen.dart';

import 'Theme/yommie_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Yommie',
      theme: YommieTheme.buildLightTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
