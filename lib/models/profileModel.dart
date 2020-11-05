import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/provider/rest.dart';

class ProfileModel {
  Future userProfile(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "user-profile.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      } else {
        final jsonResponse = json.decode(response);
        return jsonResponse;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> userProfileUpdate(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'user-profile-update.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.success, reason, "Ok", () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      } else {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.error, reason, "Ok", () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> userChangePassword(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'change-password.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.success, reason, "Ok", () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      } else {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.error, reason, "Ok", () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
