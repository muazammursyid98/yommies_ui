import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yommie/models/profileModel.dart';

class EditProfile extends StatefulWidget {
  final String userImage;
  final String username;
  final String email;
  final String gender;
  final String dateOfBirth;

  EditProfile(
      {this.userImage,
      this.username,
      this.email,
      this.gender,
      this.dateOfBirth});

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

  File imageFile;
  String userImage;
  final picker = ImagePicker();

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

  _openGallery(BuildContext context) async {
    var pitcure =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (pitcure != null) {
      File imageCrop = await ImageCropper.cropImage(
          sourcePath: pitcure.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            // CropAspectRatioPreset.ratio3x2,
            // CropAspectRatioPreset.original,
            // CropAspectRatioPreset.ratio4x3,
            // CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (mounted) {
        this.setState(() {
          userImage = null;
          imageFile = imageCrop;
        });
      }
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var pitcure =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pitcure != null) {
      File imageCrop = await ImageCropper.cropImage(
        sourcePath: pitcure.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (mounted) {
        setState(() {
          userImage = null;
          imageFile = imageCrop;
        });
      }
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    setState(() {
      userImage = widget.userImage;
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
                                fit: BoxFit.cover,
                                image: userImage != null
                                    ? NetworkImage(
                                        "https://yomies.com.my/pages/user/photo/${widget.userImage}?v=${DateTime.now().millisecondsSinceEpoch}",
                                      )
                                    : imageFile != null
                                        ? FileImage(imageFile)
                                        : AssetImage('assets/images/placeholder-avatar.png'),
                              ),
                            ),
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
                                onTap: () {
                                  _showChoiceDialog(context);
                                },
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
        if (imageFile != null) {
          List<int> imageBytes = imageFile.readAsBytesSync();
          String base64Image = base64.encode(imageBytes);
          var jsons = {};
          jsons["username"] = username.text;
          jsons["dob"] = dateOfBirth.text;
          jsons["gender"] = choice;
          jsons["userimage"] = base64Image;

          ProfileModel().userProfileUpdate(jsons, context);
        } else {
          var jsons = {};
          jsons["username"] = username.text;
          jsons["dob"] = dateOfBirth.text;
          jsons["gender"] = choice;
          ProfileModel().userProfileUpdate(jsons, context);
        }
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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(
            "Add Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Choose from gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text("Take photo"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
