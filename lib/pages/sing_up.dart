import 'package:flutter/material.dart';
import 'package:yommie/Theme/yommie_theme.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/widget/custom_dropdown2.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _selected = 1;
  final GlobalKey _key = new GlobalKey();

  Gender selectedUser;
  List genders = [const Gender(1, 'Male'), const Gender(2, 'Female')];

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

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
                  contentPadding: EdgeInsets.only(left: 30),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
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
                  contentPadding: EdgeInsets.only(left: 30),
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
              SizedBox(height: 15),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 30),
                  hintText: 'Re-Password',
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
                  contentPadding: EdgeInsets.only(left: 30),
                  hintText: 'mm/dd/yyyy',
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
              CustomDropdownButton(
                elevation: 19,
                value: selectedUser,
                items: genders.map((dynamic user) {
                  return new DropdownMenuItem(
                    value: user,
                    child: selectedUser == null
                        ? new Text(
                            user.name,
                            style: new TextStyle(color: Colors.grey),
                          )
                        : selectedUser.name == user.name
                            ? new Text(
                                user.name,
                                style: new TextStyle(color: Colors.black),
                              )
                            : new Text(
                                user.name,
                                style: new TextStyle(color: Colors.grey),
                              ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 40,
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  child: Text("SUBMIT"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: HexColor("#f8df78"),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: DropdownButtonHideUnderline(
              child: new DropdownButton(
                hint: new Text("Select gender"),
                isDense: true,
                value: selectedUser == null ? null : selectedUser,
                onChanged: (dynamic newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
                items: genders.map((dynamic user) {
                  return new DropdownMenuItem(
                    value: user,
                    child: selectedUser == null
                        ? new Text(
                            user.name,
                            style: new TextStyle(color: Colors.grey),
                          )
                        : selectedUser.name == user.name
                            ? new Text(
                                user.name,
                                style: new TextStyle(color: Colors.black),
                              )
                            : new Text(
                                user.name,
                                style: new TextStyle(color: Colors.grey),
                              ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Gender {
  const Gender(this.id, this.name);
  final String name;
  final int id;
}
