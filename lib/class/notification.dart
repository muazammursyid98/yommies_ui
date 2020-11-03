import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yommie/pages/navigation_bar.dart';

class MyNotification {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _firebaseMessaging = FirebaseMessaging();
  final List messages = [];
  BuildContext contextx;
  String userIdx;

  Future onSelectNotification(String payload) async {
    //! push page
    Navigator.push(
      contextx,
      MaterialPageRoute(
        builder: (BuildContext context) => NavigationBar(
          userId: userIdx,
          page: null,
        ),
      ),
    );
  }

  void handleRouting(message, BuildContext context, userId) {
    //! push page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NavigationBar(
          userId: userId,
          page: null,
        ),
      ),
    );
  }

  void sendTokenToServer(String fcmToken) {
    // send key to your server to allow server to use
    // this token to send push notifications
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  subcribeMessage(userId, BuildContext context) {
    contextx = context;
    userIdx = userId;
    var android = new AndroidInitializationSettings('yomiesLogo');
    var ios = new IOSInitializationSettings();
    // var macOS = new MacOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic('$userId');
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      handleRouting(messages, context, userId);
    }, onLaunch: (Map<String, dynamic> message) async {
      handleRouting(messages, context, userId);
    }, onResume: (Map<String, dynamic> message) async {
      handleRouting(messages, context, userId);
    });
    //Needed by iOS only
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print(settings);
    });
  }

  unsubscribeMessage(userId) {
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.unsubscribeFromTopic("$userId");
  }
}
