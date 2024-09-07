import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliery_app/Screens/SplashScreen/on_board.dart';
import 'package:deliery_app/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../Auth/login.dart';
import '../../Home/home.dart';
import '../Auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // void getPermission() async{
  //   // ignore: unused_local_variable
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.bluetoothScan,
  //     Permission.bluetoothConnect,
  //   ].request();
  // }

  @override
  void initState() {
    super.initState();
    init();
    // getPermission();
  }

  // var currentUser = FirebaseAuth.instance.currentUser;

  void init() async {
    await Future.delayed(const Duration(seconds: 2), () {
      // if (currentUser != null) {
      // const Home().launch(context);
      // } else {
      Navigator.pop(context);
      LoginScreen().launch(context);
      // const Home().launch(context);
      // }
    });
    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height() / 3,
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 120,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage('images/Kacc.mn Logo.png'),
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Center(
                  child: Text(
                    'Powered By KACC MALL LLC',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0),
                  ),
                ),
                Center(
                  child: Text(
                    'V 1.0.0',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
