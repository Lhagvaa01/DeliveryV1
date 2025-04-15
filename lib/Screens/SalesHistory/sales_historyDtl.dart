// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unnecessary_null_comparison, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../HTTP Post&Get/post_get.dart';
import '../../constant.dart';
import '../../model/sales_history_dtl.dart';
import '../../model/sales_history_hdr.dart';
import '../../model/search_serial.dart';
import '../Sales/loading_dialog.dart';
// import '../loading_dialog.dart';

class SalesHistoryDTL extends StatefulWidget {
  const SalesHistoryDTL({
    super.key,
  });

  @override
  State<SalesHistoryDTL> createState() => _SalesHistoryDTLState();
}

class _SalesHistoryDTLState extends State<SalesHistoryDTL> {
  SalesHistoryHdr _gets = new SalesHistoryHdr();
  @override
  void initState() {
    // getSalesHistoryDTLList(context, shistoryDtlId).then((value) {
    //   setState(() {
    //     _gets = (value);
    //   });
    // });
    _gets = shistoryDtlId;
    print(jsonEncode(shistoryDtlId));
    super.initState();
  }

  clearField() {
    setState(() {
      searchField.clear();
    });
  }

  TextEditingController searchField = TextEditingController();
  var arg;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Борлуулалтын түүх"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _gets.pk != null
            ? Column(
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
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Хүлээлгэн өгсөн: "),
                            Text(
                              _gets.infoOutSector!.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Хүлээн авсан:"),
                            Text(
                              _gets.infoToSector.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Тэмдэглэл: "),
                            Text(
                              _gets.description.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Нийт Үнэ: "),
                            Text(
                              _gets.totalPrice.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
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
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xffEAEFFA),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Хүлээлгэн өгсөн бараа',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          // ЭНЭ ХЭСГИЙГ EXPANDED БОЛГОНО
                          Expanded(
                            child: ListView.builder(
                              physics:
                                  BouncingScrollPhysics(), // эсвэл AlwaysScrollableScrollPhysics()
                              itemCount: _gets.historyProducts?.length ?? 0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Барааны код №:",
                                              style: TextStyle(fontSize: 14)),
                                          Text(
                                            _gets.historyProducts![index]
                                                .product!.itemCode
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Барааны нэр:",
                                              style: TextStyle(fontSize: 14)),
                                          Text(
                                            _gets.historyProducts![index]
                                                .product!.itemName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Тоо/ш:",
                                              style: TextStyle(fontSize: 14)),
                                          Text(
                                            _gets.historyProducts![index]
                                                .quantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        height: 1.5,
                                        width: double.infinity,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: LoadingIndicator(text: "Түр хүлээнэ үү..."),
              ),
      ),
    );
  }
}
