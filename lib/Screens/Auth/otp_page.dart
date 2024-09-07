// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, deprecated_member_use, prefer_const_declarations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:deliery_app/GlobalComponents/otp_form.dart';
import 'package:deliery_app/constant.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var _emailCtr = TextEditingController();
  var _otpCtr = TextEditingController();

  @override
  void initState() {
    _emailCtr.text = "zayalhagva6@gmail.com";

    _otpCtr.text = "1234";
    // emailAuth = new EmailAuth(
    //   sessionName: "Sample session",
    // );
    // emailAuth.config(remoteServerConfiguration);
    super.initState();
  }

  String username = 'sales@kacc.mn';
  String password = 'b2Y4j!1f';
  String name = "Kacc.mn";
  String email = "zayalhagva6@gmail.com";
  String subject = "Test";
  String message = "1234";
  final serviceId = 'service_pbxx08m';
  final templateId = 'template_blxmkyj';
  final userId = 'bv7kEwKiE5XD8XwPL';
  // Future sendEmail({

  // }) async {
  //   final serviceId = 'service_u0ppmad';
  //   final templateId = 'template_blxmkyj';
  //   final userId = 'bv7kEwKiE5XD8XwPL';
  //   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(
  //       {
  //         'service_id': serviceId,
  //         'template_id': templateId,
  //         'user_id': userId,
  //         'tempale_params': {
  //           'user_name': name,
  //           'user_email': email,
  //           'user_subject': subject,
  //           'user_message': message,
  //         },
  //       },
  //     ),
  //   );

  //   print(response.body);
  // }

  fetchPost() async {
    // Object rawBody = jsonDecode(body);
    // print(rawBody);
    try {
      var httpClient = new HttpClient();
      var uri = new Uri.https('', 'api.emailjs.com/api/v1.0/email/send-form');
      print(uri);

      Object body = json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'tempale_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          },
        },
      );

      var request = await httpClient.postUrl(uri);
      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');
      request.write(body);
      print(body);
      // ignore: unused_local_variable
      var response = await request.close();
      var responseBody = await response.transform(Utf8Decoder()).join();
      await Future.delayed(const Duration(milliseconds: 500));
      print(responseBody);
      httpClient.close();
    } catch (e) {
      toasty(context, "Сервэрийн алдаа: " + '$e',
          bgColor: Colors.redAccent,
          textColor: whiteColor,
          gravity: ToastGravity.BOTTOM,
          length: Toast.LENGTH_LONG);
      print("Сервэрийн алдаа: " + '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('images/changePass.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Нууц Үг Солих',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Таны мэйл хаяг руу баталгаажуулах код илгээсэн : rieadstore@gmail.com",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kGreyTextColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                OtpForm(
                  pressed: () {
                    print("Send OTP");
                    fetchPost();

                    Object body = json.encode(
                      {
                        'service_id': serviceId,
                        'template_id': templateId,
                        'user_id': userId,
                        'tempale_params': {
                          'user_name': name,
                          'user_email': email,
                          'user_subject': subject,
                          'user_message': message,
                        },
                      },
                    );
                    print(body);
                    // sendOTP();

                    // Navigator.pushNamed(context, '/success');
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Код очоогүй юу?',
                        style: TextStyle(
                          color: kGreyTextColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Ахин илгээх',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
