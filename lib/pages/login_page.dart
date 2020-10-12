import 'package:flutter/material.dart';
import 'package:yommie/Theme/yommie_theme.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/pages/home_page.dart';
import 'package:yommie/pages/navigation_bar.dart';
import 'package:yommie/pages/sing_up.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
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
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logoyommie.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: HexColor("#f8df78"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide:
                        BorderSide(color: HexColor("#f8df78"), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: HexColor("#f8df78")),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black54,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: HexColor("#f8df78"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide:
                        BorderSide(color: HexColor("#f8df78"), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: HexColor("#f8df78")),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => NavigationBar(),
                      ),
                    );
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
                    onTap: () {},
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
