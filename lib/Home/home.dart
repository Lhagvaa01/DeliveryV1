import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:deliery_app/Screens/Home/home_screen.dart';
// import 'package:deliery_app/Screens/SalesHistory/sales_historyHdr.dart';
// import 'package:serial_reg/Screens/Purchase/purchase_contact.dart';
// import 'package:serial_reg/Screens/Report/reports.dart';
// import 'package:serial_reg/Screens/Settings/settings_screen.dart';

import '../../constant.dart';
import '../Screens/Sales/add_sales.dart';
import '../Screens/Sales/history_screens.dart';
import 'home_screen.dart';
// import '../Sales/add_sales.dart';
// import '../Settings/settings_screen.dart';
// import '../history_screens.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  // static const List<Widget> _widgetOptions = <Widget>[HomeScreen(), PurchaseContact(), Reports(), SettingScreen()];
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddSalesScreen(),
    HistoryScreens(),
    // SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 3) {
        EasyLoading.showError('Coming Soon');
      } else {
        _selectedIndex = index;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 6.0,
        selectedItemColor: kMainColor,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FeatherIcons.shoppingCart),
            label: 'Sales',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FeatherIcons.fileText),
            label: 'Reports',
          ),
          const BottomNavigationBarItem(
              icon: Icon(FeatherIcons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
