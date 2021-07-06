import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/provider/rest.dart';

class SignUpModels {
  static Future registerPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "register.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        Fluttertoast.showToast(
            msg: "√ Successfully registered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        final map = json.decode(response);
        String reason = map["reason"];
        DialogAction().alertDialogOneButton(
            context, "Failed", CoolAlertType.error, reason, "Ok", () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print(e);
      return e;
    }
  }
}
