// ignore: import_of_legacy_library_into_null_safe

// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:serial_reg/Provider/customer_provider.dart';
// import 'package:deliery_app/Screens/Home/components/grid_items.dart';
// import 'package:serial_reg/Screens/Profile%20Screen/profile_details.dart';
import 'package:deliery_app/constant.dart';
// import 'package:serial_reg/model/personal_information_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/login_info.dart';
import '../Screens/Profile Screen/profile_details.dart';
import 'components/grid_items.dart';
// import '../Profile Screen/profile_details.dart';
// import '../Sales/add_sales.dart';

// import '../../Provider/profile_provider.dart';
// import '../Sales/sales_contact.dart';
// import '../Shimmers/home_screen_appbar_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> color = [
    const Color(0xffEDFAFF),
    const Color(0xffFFF6ED),
    const Color(0xffEAFFEA),
    const Color(0xffEAFFEA),
    const Color(0xffEDFAFF),
    const Color(0xffFFF6ED),
    const Color(0xffFFF6ED),
  ];
  List<Map<String, dynamic>> sliderList = [
    {
      "icon": 'images/banner1.png',
    },
    {
      "icon": 'images/banner2.png',
    }
  ];
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // Consumer(builder: (context, ref, __) {
    //   ref.watch(customerProvider);
    //   return Container();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        const ProfileDetails().launch(context);
                        print("Icon");
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                loginInfo.surname == "Эр"
                                    ? loginImg[0]
                                    : loginImg[1],
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      loginInfo.name.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kDarkWhite,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      EasyLoading.showInfo('Coming Soon');
                    },
                    child: const Icon(
                      Icons.notifications_active,
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  crossAxisCount: 1,
                  children: List.generate(
                    homeScreenButtons.length,
                    (index) => HomeGridCards(
                      gridItems: homeScreenButtons[index],
                      color: color[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeGridCards extends StatelessWidget {
  const HomeGridCards({Key? key, required this.gridItems, required this.color})
      : super(key: key);
  final GridItems gridItems;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: avoid_unnecessary_containers
    return Card(
      elevation: 2,
      color: color,
      child: FittedBox(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                if (gridItems.route != '') {
                  Navigator.of(context).pushNamed('/${gridItems.route}');
                }
                print('/${gridItems.route}');
              },
              child: Column(
                children: [
                  Image(
                    height: 70,
                    width: size.width,
                    image: AssetImage(
                      gridItems.icon.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      gridItems.title.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
