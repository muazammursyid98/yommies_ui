import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/models/forgotPasswordModel.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  ChangePassword({this.email});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/yomiesKL.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Set the new pasword for your account to you can login and access all the features. ",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: password,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: HexColor("#FFF5CC"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide:
                            BorderSide(color: HexColor("#FFF5CC"), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: HexColor("#FFF5CC")),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: confirmPassword,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: HexColor("#FFF5CC"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide:
                            BorderSide(color: HexColor("#FFF5CC"), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: HexColor("#FFF5CC")),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: RaisedButton(
                      color: HexColor('#CAF8FC'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if (password.text == confirmPassword.text) {
                          var jsons = {};
                          jsons["email"] = widget.email;
                          jsons["password"] = password.text;
                          ForgotPasswordModel().forgotPassword3(jsons, _scaffoldKey.currentContext);
                        } else {
                          DialogAction().alertDialogOneButton(
                              context,
                              "Failed !",
                              CoolAlertType.error,
                              "Please try again your password not matched",
                              "Ok", () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: Text("RESET PASSWORD"),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 15,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
