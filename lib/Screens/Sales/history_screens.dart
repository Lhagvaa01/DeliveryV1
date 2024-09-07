// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
import '../../constant.dart';

// import '../GlobalComponents/button_global.dart';
// import '../constant.dart';

class HistoryScreens extends StatefulWidget {
  const HistoryScreens({super.key});

  @override
  State<HistoryScreens> createState() => _HistoryScreensState();
}

class _HistoryScreensState extends State<HistoryScreens> {
  TextEditingController startDateCon = TextEditingController();
  TextEditingController endDateCon = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    startDateCon.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    endDateCon.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Түүх"),
      ),
      body: Consumer(builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: Container(
              height: size.height / 2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Эхлэх",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              color: Colors.amber,
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                startDateCon.text,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            onTap: (() async {
                              final DateTime? picked = await showDatePicker(
                                initialDate: selectedDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                                context: context,
                              );
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                  startDateCon.text = DateFormat("yyyy-MM-dd")
                                      .format(selectedDate);
                                  startDate = DateFormat("yyyy-MM-dd")
                                      .format(selectedDate);
                                });
                              }
                            }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Дуусах",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: Container(
                              color: Colors.amber,
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                endDateCon.text,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                initialDate: selectedDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                                context: context,
                              );
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                  endDateCon.text = DateFormat("yyyy-MM-dd")
                                      .format(selectedDate);
                                  endDate = DateFormat("yyyy-MM-dd")
                                      .format(selectedDate);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ButtonGlobal(
                    height: 100,
                    iconWidget: Icons.history,
                    buttontext: 'Тайлан ',
                    iconColor: Colors.white,
                    buttonDecoration:
                        kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/salesHistoryHDR');
                    },
                  ),
                  // ButtonGlobal(
                  //   height: 100,
                  //   iconWidget: Icons.history,
                  //   buttontext: 'Засварын түүх  ',
                  //   iconColor: Colors.white,
                  //   buttonDecoration:
                  //       kButtonDecoration.copyWith(color: kMainColor),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/repairHistoryHDR');
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
