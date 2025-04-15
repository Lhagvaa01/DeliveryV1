// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../GlobalComponents/login_background.dart';
// import '../../HTTP Post&Get/post_get.dart';
import '../../HTTP Post&Get/post_get.dart';
import '../../Home/home.dart';
import '../../constant.dart';
import '../../model/login_body.dart';
// import '../../model/login_body.dart';
// import '../Home/home.dart';
import '../loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Box<String> dataBase;
  bool _saveName = false;
  var username = TextEditingController();
  var passcode = TextEditingController();

  bool isLoading = false;

  var loginBody = LoginBody();

  @override
  void initState() {
    super.initState();
    dataBase = Hive.box<String>("DataBase");

    if (dataBase.get('db.ISSAVE') == "true") {
      print("IsSave: " + dataBase.get('db.ISSAVE').toString());
      username.text = dataBase.get('db.USERNAME').toString();
      passcode.text = dataBase.get('db.PASSWORD').toString();
      _saveName = true;
    }
  }

  LoginValidate() {
    loginBody = LoginBody(
      username: username.text,
      password: passcode.text,
    );

    // Home().launch(context);
    // isLoading = false;
    postLoginCheck(context, jsonEncode(loginBody)).then((value) {
      setState(() {
        if (value.message == "Login successful") {
          Home().launch(context);
          isLoading = false;
          SaveNamePass();
        } else {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Бүртгэлгүй эсвэл нууц үг буруу!",
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
      });
    });
  }

  SaveNamePass() {
    if (_saveName) {
      dataBase.put('db.ISSAVE', "true");
      dataBase.put('db.USERNAME', username.text);
      dataBase.put('db.PASSWORD', passcode.text);
    } else {
      dataBase.put('db.ISSAVE', "false");
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child:
                  Image.asset("images/login/Logo.png", width: size.width * 0.5),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                  labelText: "Нэвтрэх нэр",
                  hintText: 'Нэвтрэх нэр оруулна уу',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Нэвтрэх нэр хоосон байна!!!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: passcode,
                decoration: InputDecoration(
                  labelText: "Нууц үг",
                  hintText: 'Нууц үг оруулна уу',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Нууц үг хоосон байна!!!';
                  }
                  return null;
                },
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            CheckboxListTile(
              contentPadding: EdgeInsets.only(left: 30),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: kMainColor,
              title: Text('Нэвтрэх нэр нууц үг сануулах'),
              value: _saveName,
              onChanged: (value) {
                setState(() {
                  _saveName = !_saveName;
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });

                  LoginValidate();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "НЭВТРЭХ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            isLoading
                ? Container(
                    child: LoadingIndicator(text: " Түр хүлээнэ үү.... "),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
