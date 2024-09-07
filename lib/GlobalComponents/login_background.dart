// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("images/login/top1.png", width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("images/login/top2.png", width: size.width),
          ),
          // Positioned(
          //   top: 130,
          //   left: 30,
          //   // right: 20,
          //   child:
          //       Image.asset("images/Kacc.mn Logo.png", width: size.width * 0.5),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("images/login/bottom1.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("images/login/bottom2.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
