import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/pages/changePassword.dart';
import 'package:yommie/pages/otp_code.dart';
import 'package:yommie/provider/rest.dart';

class ForgotPasswordModel {
  void forgotPassword(jsons, context, type) async {
    try {
      var result = await GetAPI.providers(jsons, 'forgot-password-1.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        if (type == "resendCode") {
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Otp(
                email: jsons["email"],
              ),
            ),
          );
        }
      } else {
        if (type == "resendCode") {
        } else {
          final map = json.decode(response);
          String reason = map['reason'];
          String message = map['message'];
          DialogAction().alertDialogOneButton(
              context, message, CoolAlertType.error, reason, "Ok", () {
            Navigator.of(context).pop();
          });
        }
      }
    } catch (e) {}
  }

  forgotPassword2(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'forgot-password-2.php');
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChangePassword(
              email: jsons["email"],
            ),
          ),
        );
      } else {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.error, reason, "Ok", () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {}
  }

  forgotPassword3(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, 'forgot-password-3.php');
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
    } catch (e) {}
  }
}
