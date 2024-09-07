// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, unnecessary_null_comparison, prefer_is_empty

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

// import '../../HTTP Post&Get/post_get.dart';
import '../../constant.dart';
import '../../model/sales_history_hdr.dart';
import '../Sales/loading_dialog.dart';
// import '../loading_dialog.dart';

class SalesHistoryHDR extends StatefulWidget {
  const SalesHistoryHDR({
    super.key,
  });

  @override
  State<SalesHistoryHDR> createState() => _SalesHistoryHDRState();
}

class _SalesHistoryHDRState extends State<SalesHistoryHDR> {
  var _gets = <SalesHistoryHdr>[];
  bool wait = true;

  @override
  void initState() {
    search("");

    super.initState();
  }

  void dispose() {
    _gets.clear();
    super.dispose();
  }

  clearField() {
    setState(() {
      searchField.clear();
    });
  }

  search(String valuData) {
    // getSalesHistoryHDRList(context, valuData, startDate, endDate).then((value) {
    //   setState(() {
    //     if (value.isNotEmpty) {
    //       _gets = [];
    //       _gets.addAll(value);
    //     } else {
    //       wait = !wait;
    //     }
    //   });
    // }).then((_) => () {
    //       setState(() {});
    //     });
  }

  TextEditingController searchField = TextEditingController();
  var arg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Борлуулалтын түүх"),
      ),
      body: Consumer(builder: (context, ref, child) {
        // AsyncValue<PersonalInformationModel> userProfileDetails =
        //     ref.watch(profileDetailsProvider);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/reports1.png'),
                      fit: BoxFit.scaleDown,
                    ),
                    // borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppTextField(
                    controller: searchField,
                    autoFocus: true,
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                      labelText: 'Хайлт',
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      search(value);
                      print(_gets.first.createDate);
                    }),
              ),
              _gets.length != 0
                  ? Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 203, 213, 235)),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: _gets.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  shistoryDtlId = _gets[index].id.toString();
                                  Navigator.pushNamed(
                                      context, '/salesHistoryDTL');
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Харилцагч Нэр:",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          _gets[index]
                                              .customerId![1]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Төлбөрийн хэлбэр:",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          _gets[index].paymentId![1].toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Хүлээлгэж өгсөн:",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          _gets[index].delivered.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Борлуулсан огноо:",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          _gets[index].createDate.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      height: 1.5,
                                      width: double.infinity,
                                      color: Colors.black54,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  : wait
                      ? Container(
                          child: LoadingIndicator(text: "Түр хүлээнэ үү..."),
                        )
                      : Text("Тухайн өдөрт борлуулалт байхгүй байна."),
            ],
          ),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     size: 40,
      //   ),
      //   backgroundColor: Colors.green[400],
      //   onPressed: () {
      //     Navigator.pop(context);
      //     Navigator.pushNamed(context, '/newCustomer');
      //   },
      // ),
    );
  }
}
