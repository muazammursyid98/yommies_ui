import 'dart:convert';

import 'package:http/http.dart';

class SendNotification {
  static final Client client = Client();
  static Future<Response> sendTo(userId, title, body) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: jsonEncode({
          "notification": {
            "title": "$title",
            "body": "$body",
            "color": "#6D67BC",
            "sound": "default",
            "content_available": 1,
          },
          "data": {
            // "notificationId": "$dataOnClick",
            "type": "pushNotification",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          },
          "to": "/topics/$userId",
          "priority": "high",
          "mutable_content": true,
          "restricted_package_name": ""
        }),
        //---------------------------//
        // body: json.encode({
        //   'notification': {'body': 'testing123', 'title': 'Collected'},
        //   'priority': 'high',
        //   'data': {
        //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        //     'id': '1',
        //     'status': 'done',
        //   },
        //   'to': '/topics/$ekuponId', //hantar topics
        // }),
        // ---------------------------//
        //! ==== key production ==== //
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAzoLNI3U:APA91bHdQVtCHbmlX-2nx6G00d1NuIHDO0fU1S6zId2m6YBGeCtgIYKd5U6X0a-8b9m8zTn9y4OyOyfSSTsj7LunXM6D1BIWT-TECJmJIkhtsepkiURF1d0u4iDVnxCvEdiAiiRPl4kw', //hantar key
        },
        //! == key development === //
        //              headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization':
        //       'key=AAAAtHzYVk4:APA91bHIaNnz3zJVfoUMWvLIdCTjB0lUXC8jF_48h1MDj7x8JMWYDOj8A8hjY2ODihO8QLDewHIHaBLLg6HbWs-ksI5OLbWfdcYlUgOHfzxDymj1dHyhN-dPTQRsGaE0qA09shGYxZ0O', //hantar key
        // },
      );
}
