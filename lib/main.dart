
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/pages/splash_screen.dart';
import 'package:yommie/provider/rest.dart';

import 'Theme/yommie_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
  // var firstName = prefs.getString('firstname');
  // var email = prefs.getString('email');

  GetAPI.setupHTTPHeader(prefs.getString('token'));
  runApp(MyApp(
    userId: userId,
  ));
}

class MyApp extends StatelessWidget {
  final String userId;

  MyApp({this.userId});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Yommie',
      theme: YommieTheme.buildLightTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        userId: userId,
      ),
    );
  }
}
