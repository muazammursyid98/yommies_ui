import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/class/notification.dart';
import 'package:yommie/models/profileModel.dart';
import 'package:yommie/pages/change_password.dart';
import 'package:yommie/pages/reset_password.dart';
import 'package:yommie/pages/edit_profile.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  ProfilePage({this.userId});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;
  var response;
  @override
  void initState() {
    var jsons = {};
    ProfileModel().userProfile(jsons, context).then((value) {
      setState(() {
        response = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: Color(0xfffcf1f2),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              height: 410,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Personal Info",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontFamily: 'Karla',
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/user1.jpg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Karla',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Date Of Birth",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Karla',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Karla',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Current Point",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Karla',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    response["user_name"],
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontFamily: 'Karla',
                                    ),
                                  ),
                                  Text(
                                    response["dob"],
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontFamily: 'Karla',
                                    ),
                                  ),
                                  Text(
                                    response["gender"],
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontFamily: 'Karla',
                                    ),
                                  ),
                                  Text(
                                    response["user_point"],
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontFamily: 'Karla',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: OutlineButton(
                          child: Text('CHANGE PASSWORD',
                              style: TextStyle(color: Colors.pink)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.8,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: ChangePassword(),
                              ),
                            );
                          },
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: OutlineButton(
                          child: Text(
                            'EDIT PROFILE ',
                            style: TextStyle(color: Colors.pink),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.8,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: EditProfile(
                                  username: response["user_name"],
                                  email: response["email"],
                                  gender: response["gender"],
                                  dateOfBirth: response["dob"],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Karla',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(response["email"]),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        _goLogOut();
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  _goLogOut() async {
    DialogAction().alertDialog(context, "Alert !", CoolAlertType.warning,
        "Are you sure want to logout? ", "Yes", "No", () async {
      MyNotification().unsubscribeMessage(widget.userId);
      MyNotification().unsubscribeMessage(widget.userId);
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      );
      Navigator.of(context).pushReplacement(route);
    }, () {
      Navigator.of(context).pop();
    });
  }
}
