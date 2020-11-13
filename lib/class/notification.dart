import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yommie/pages/navigation_bar_dummy.dart';

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
        builder: (BuildContext context) => NavigationBarDummy(
          userId: userIdx,
          page: null,
        ),
      ),
    );
  }

  void handleRouting(message, BuildContext context, userId) {
    //! push page

    if (message.containsKey('notification')) {
      // Handle notification message
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationBarDummy(
            userId: userId,
            page: null,
          ),
        ),
      );
    }
  }

  void sendTokenToServer(String fcmToken) {
    // send key to your server to allow server to use
    // this token to send push notifications
  }

  showNotification(Map<String, dynamic> msg) async {
    final notification = msg['notification'];
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0,
        notification['title'].replaceAll('&#39;', '’'),
        notification['body'].replaceAll('&#39;', '’'),
        platform);
  }

  callNotification(userId, BuildContext context) {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      showNotification(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      handleRouting(messages, context, userId);
    }, onResume: (Map<String, dynamic> message) async {
      handleRouting(messages, context, userId);
    });
  }

  subcribeMessage(userId, BuildContext context) {
    contextx = context;
    userIdx = userId;
    var android = new AndroidInitializationSettings('yomieslogo');
    var ios = new IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        var android = new AndroidNotificationDetails(
            'id', 'channel ', 'description',
            priority: Priority.high, importance: Importance.max);
        var iOS = new IOSNotificationDetails();
        var platform = new NotificationDetails(android: android, iOS: iOS);
        await flutterLocalNotificationsPlugin.show(
            id,
            title.replaceAll('&#39;', '’'),
            body.replaceAll('&#39;', '’'),
            platform);
      },
    );
    var platform = new InitializationSettings(android: android, iOS: ios);
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print(settings);
      });
    }
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic('$userId');
    callNotification(userId, context);
  }

  unsubscribeMessage(userId) {
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.unsubscribeFromTopic("$userId");
  }
}
