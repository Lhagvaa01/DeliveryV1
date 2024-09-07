// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliery_app/GlobalComponents/button_global.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Home/home.dart';
import '../../constant.dart';
// import '../Home/home.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150.0,
            ),
            const Image(
              image: AssetImage('images/success.png'),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              'Амжилттай',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "rieadstore@gmail.com : Хэрэглэгчийн нууц үг амжилттай солигдлоо.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 20.0,
                ),
              ),
            ),
            const Spacer(),
            ButtonGlobalWithoutIcon(
                buttontext: 'Үрлгэлжлүүлэх',
                buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                onPressed: () {
                  const Home().launch(context);
                  // Navigator.pushNamed(context, '/home');
                },
                buttonTextColor: Colors.white),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
