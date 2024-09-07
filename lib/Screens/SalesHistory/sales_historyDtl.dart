// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unnecessary_null_comparison, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../HTTP Post&Get/post_get.dart';
import '../../constant.dart';
import '../../model/sales_history_dtl.dart';
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
  SalesHistoryDtl _gets = new SalesHistoryDtl();
  @override
  void initState() {
    // getSalesHistoryDTLList(context, shistoryDtlId).then((value) {
    //   setState(() {
    //     _gets = (value);
    //   });
    // });
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
        child: _gets.id != null
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
                            Text("Харилцагчийн нэр: "),
                            Text(
                              _gets.customerId![1].toString(),
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
                            Text("Төлбөрийн хэлбэр: "),
                            Text(
                              _gets.paymentId![1].toString(),
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
                            Text("Хүлээлгэж өгсөн:"),
                            Text(
                              _gets.delivered.toString(),
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
                              _gets.note.toString(),
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
                                  'Худалдан авсан бараа',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _gets.details?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    // getCustomer = _gets[index];
                                    // Navigator.pop(context);
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Сериал №:",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            _gets.details![index].serialId![1]
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
                                            "Барааны нэр:",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            _gets.details![index].product![1]
                                                .toString(),
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
