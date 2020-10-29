import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yommie/models/profileModel.dart';

class EditProfile extends StatefulWidget {
  final String username;
  final String email;
  final String gender;
  final String dateOfBirth;

  EditProfile({this.username, this.email, this.gender, this.dateOfBirth});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final username = TextEditingController();
  final email = TextEditingController();
  final dateOfBirth = TextEditingController();

  final String male = "Male";
  final String female = "Female";

  String _radioValue; //Initial definition of radio button value
  String choice;

  var maskFormatter = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Male':
          choice = value;
          break;
        case 'Female':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  void initState() {
    setState(() {
      username.text = widget.username;
      email.text = widget.email;
      dateOfBirth.text = widget.dateOfBirth;
      if (widget.gender == "Male") {
        _radioValue = male;
        choice = male;
      } else {
        _radioValue = female;
        choice = female;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.18,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 30, top: 30, right: 30),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
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
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: ClipOval(
                            child: Material(
                              color: Colors.pink[300], // button color
                              child: InkWell(
                                splashColor: Colors.pink[300], // inkwell color
                                child: SizedBox(
                                    width: 26,
                                    height: 26,
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                    )),
                                onTap: () {},
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontFamily: 'Karla',
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      disabledColor: Colors.grey,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: email,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontFamily: 'Karla',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontFamily: 'Karla',
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 0,
                        ),
                      ),
                      Radio(
                        value: male,
                        groupValue: _radioValue,
                        onChanged: radioButtonChanges,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontFamily: 'Karla',
                        ),
                      ),
                      Radio(
                        value: female,
                        groupValue: _radioValue,
                        onChanged: radioButtonChanges,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontFamily: 'Karla',
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: dateOfBirth,
                    keyboardType: TextInputType.number,
                    inputFormatters: [maskFormatter],
                    decoration: InputDecoration(
                      labelText: "Date Of Birth",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontFamily: 'Karla',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomWidget())
        ],
      ),
    );
  }

  GestureDetector bottomWidget() {
    return GestureDetector(
      onTap: () {
        var jsons = {};
        jsons["username"] = username.text;
        jsons["dob"] = dateOfBirth.text;
        jsons["gender"] = choice;
        ProfileModel().userProfileUpdate(jsons, context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "SAVE CHANGES",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
