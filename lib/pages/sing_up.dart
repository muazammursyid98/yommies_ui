import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/widget/custom_dropdown2.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  int _selected = 1;
  Gender selectedUser;
  List genders = [const Gender(1, 'Male'), const Gender(2, 'Female')];

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final dateOfBirth = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
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
                    SizedBox(height: 15),
                    nameInput(),
                    SizedBox(height: 15),
                    emailInput(),
                    SizedBox(height: 15),
                    passwordInput(),
                    SizedBox(height: 15),
                    confirmPasswordInput(),
                    SizedBox(height: 15),
                    dateOfBirthInput(),
                    SizedBox(height: 15),
                    CustomDropdownButton(
                      elevation: 19,
                      value: selectedUser,
                      items: genders.map((dynamic user) {
                        return new DropdownMenuItem(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
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
                        onPressed: () {
                          
                        },
                        child: Text("SUBMIT"),
                      ),
                    )
                  ],
                ),
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

  Widget nameInput() {
    return TextFormField(
      controller: username,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Username',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#f8df78"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78"), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78")),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: email,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      focusNode: FocusNode(),
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
          borderSide: BorderSide(color: HexColor("#f8df78"), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78")),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      controller: password,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#f8df78"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78"), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78")),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget confirmPasswordInput() {
    return TextFormField(
      controller: confirmPassword,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Confirm Password',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#f8df78"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78"), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78")),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget dateOfBirthInput() {
    return TextFormField(
      controller: dateOfBirth,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      autocorrect: true,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'dd/mm/yyyy',
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: HexColor("#f8df78"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78"), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: HexColor("#f8df78")),
        ),
      ),
      textInputAction: TextInputAction.next,
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
