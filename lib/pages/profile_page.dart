import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              height: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/user1.jpg'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffd6a5c0),
                              blurRadius: 40,
                              offset: Offset(0, 10),
                            ),
                          ],
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
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, top: 5),
                      width: 300,
                      child: Text(response["email"]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
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
                        child: OutlineButton(
                          child: Text('EDIT PROFILE ',
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
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Log out"),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        );
                        Navigator.of(context).pushReplacement(route);
                      })
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
