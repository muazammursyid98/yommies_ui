import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:yommie/Theme/yommie_theme.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/class/notification.dart';
import 'package:yommie/models/loginViewModels.dart';
import 'package:yommie/pages/forgot_password.dart';
import 'package:yommie/pages/sing_up.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: ResponsiveFlutter.of(context).verticalScale(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/yomiesKL.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveFlutter.of(context).verticalScale(20)),
              TextField(
                controller: email,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.grey,
                  ),
                  hintText: 'Email',
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
              SizedBox(height: 15),
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
              SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: 200,
                child: RaisedButton(
                  color: HexColor('#CAF8FC'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    var jsons = {};
                    jsons["email"] = email.text;
                    jsons["password"] = password.text;
                    LoginViewModels().loginPhp(jsons, context);
                  },
                  child: Text("LOGIN"),
                ),
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                      style: YommieTheme.display1,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    color: Colors.black54,
                    width: 2,
                    height: 14,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      // MyNotification().unsubscribeMessage('20041');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: YommieTheme.display1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
