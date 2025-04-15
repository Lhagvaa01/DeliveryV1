// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, use_key_in_widget_constructors, unnecessary_import, unused_import, depend_on_referenced_packages, unused_local_variable

import 'dart:io';
import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constant.dart';
// import '../../images/paper57.png' as img;

// ignore: must_be_immutable
class PrintPrice extends StatefulWidget {
  @override
  State<PrintPrice> createState() => _PrintPriceState();
}

class _PrintPriceState extends State<PrintPrice> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  final regStr = TextEditingController();
  final barUrl = TextEditingController();
  final shopName = TextEditingController();
  final isConnectPrint = TextEditingController();
  String? formattedDate;
  bool isLoading = false;
  bool? isConnected;

  @override
  void initState() {
    super.initState();
    getDevices();
    initializePrinter();
  }

  Future<void> initializePrinter() async {
    isConnected = await printer.isConnected;
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    checkPrint();
  }

  Future<void> checkPrint() async {
    isConnected = await printer.isConnected;
    if (isConnected != null && isConnected!) {
      isConnectPrint.text = "true";
    } else {
      isConnectPrint.text = "false";
    }
    setState(() {});
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  String removeSpecialCharacters(String tempData) {
    final output1 = tempData.replaceAll(RegExp('[Өө]'), 'e');
    final output2 = output1.replaceAll(RegExp('[Ү]'), 'Y');
    final output = output2.replaceAll(RegExp('[ү]'), 'v');
    return output;
  }

  void printItems() {
    for (int i = 0; i < salesProd.length; i++) {
      final item = salesProd[i];
      final itemString1 =
          "${i + 1}) ${salesProd[i].itemCode}   ${salesProd[i].itemBillName}";
      final itemString2 =
          "   ${salesProd[i].itemPrice} * ${salesProd[i].qty} = ${(salesProd[i].itemPrice.toDouble() * salesProd[i].qty!).toStringAsFixed(2)}";
      printer.printCustom(
        removeSpecialCharacters(itemString1),
        1,
        0,
        charset: "cp866",
      );
      printer.printCustom(
        removeSpecialCharacters(itemString2),
        1,
        0,
        charset: "cp866",
      );
    }
  }

  @override
  void dispose() {
    totalPrice = 0.0;
    isTap = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Хэвлэх",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: size.height / 1.7,
                margin: const EdgeInsets.only(left: 30, right: 30),
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("images/paper57.png"),
                  //   fit: BoxFit.fill,
                  // ),
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                // color: Colors.grey[200],
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 10, right: 10),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: "Дэлгүүрийн нэрээ бичнэ үү",
                      //       border: InputBorder.none,
                      //     ),
                      //     controller: shopName,
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //         fontSize: shopName.text.isNotEmpty ? 16 : 14,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),

                      Text(
                        "Худалдан авалт",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Баримт №: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "001",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                      Text(
                        "Хэвлэсэн огноо: " + formattedDate.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            FittedBox(
                              child: Text(
                                "Бэлтгэн нийлүүлэгч: ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "Тэгш баян арвай",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Гүйлгээний утга: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            descText,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Барааны нэр   Код   Тоо   Үнэ   Дүн",
                            style: TextStyle(fontSize: 18),
                          ),
                          FittedBox(
                            child: Text(
                              "-------------------------------------------",
                              style: TextStyle(fontSize: 12 + 12),
                            ),
                          ),
                          for (int i = 0; i < salesProd.length; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${i + 1}) ${salesProd[i].itemCode}   ${salesProd[i].itemBillName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "   ${salesProd[i].qty} *  ${salesProd[i].itemPrice}  = ${(salesProd[i].itemPrice.toDouble() * salesProd[i].qty!).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                        ],
                      ),
                      FittedBox(
                        child: Text(
                          "-------------------------------------------",
                          style: TextStyle(fontSize: 12 + 12),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Нийт үнэ: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                totalPrice.toString() + "₮",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "Хүлээлгэн өгсөн:................... ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Хүлээн авсан:................... ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),

              // SizedBox(
              //   height: 10,
              // ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "1. Хэвлэгчээ сонгоно.",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "2. Connect-дарж холболтоо хийнэ.",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "3. Print-дарж Хэвлнэ..",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 50,
                      width: size.width / 1.8,
                      child: DropdownButton<BluetoothDevice>(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        dropdownColor: Colors.white,
                        value: selectDevice,
                        hint: Text(
                          'Хэвлэгчээ сонгоно уу',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        onChanged: (device) {
                          setState(() {
                            selectDevice = device;
                            print("Selected Device: ${selectDevice?.name}");
                            print(isConnectPrint.text);
                          });
                        },
                        items: devices
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name!),
                                  value: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        printer.disconnect();
                        await Future.delayed(const Duration(seconds: 1));

                        if (selectDevice == null) {
                          Alert(
                            context: context,
                            title: "Алдаа",
                            desc: "Хэвлэгчээ сонгоно уу.",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Тийм",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 120,
                              ),
                            ],
                          ).show();
                        } else {
                          await printer.connect(selectDevice!);
                        }

                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          checkPrint();
                          print(isConnectPrint.text);
                          isLoading = false;
                        });
                      },
                      icon: Icon(
                        Icons.check,
                        size: 24.0,
                      ),
                      label: Text("Connect"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  isLoading
                      ? Column(
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                            Text("Түр хүлээнэ үү!"),
                          ],
                        )
                      : Container(),
                  Container(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          if (isConnected != null && isConnected!) {
                            String compName = removeSpecialCharacters(
                              shopName.text.isNotEmpty ? shopName.text : " ",
                            );

                            // Example print data
                            printer.printCustom(compName, 2, 1,
                                charset: "cp866");
                            await printer.isDeviceConnected(selectDevice!);

                            printer.printLeftRight(
                                removeSpecialCharacters("Худалдан авалт"),
                                "",
                                1,
                                charset: "cp866");
                            printer.printNewLine();
                            printer.printLeftRight("Баримт №: ", "001", 1,
                                charset: "cp866");
                            printer.printCustom(
                                "Хэвлэсэн огноо: " + formattedDate.toString(),
                                1,
                                0,
                                charset: "cp866");
                            printer.printCustom(
                                removeSpecialCharacters("Бэлтгэн нийлүүлэгч: "),
                                1,
                                0,
                                charset: "cp866");
                            printer.printCustom(
                                removeSpecialCharacters("Тэгш баян арвай"),
                                1,
                                0,
                                charset: "cp866");
                            printer.printCustom(
                                removeSpecialCharacters("Гүйлгээний утга: "),
                                1,
                                0,
                                charset: "cp866");
                            printer.printCustom(
                                removeSpecialCharacters(descText), 1, 0,
                                charset: "cp866");

                            printer.printNewLine();

                            printer.printCustom(
                                removeSpecialCharacters(
                                    "Нэр |  Код  | Тоо |  Үнэ  | Дүн"),
                                1,
                                1,
                                charset: "cp866");

                            printer.printCustom(
                                "------------------------------", 20, 1,
                                charset: "cp866");

                            printItems();

                            printer.printCustom(
                                "------------------------------", 20, 1,
                                charset: "cp866");

                            printer.print3Column(
                              removeSpecialCharacters("Нийт үнэ: "),
                              totalPrice.toString(),
                              "₮",
                              1,
                              charset: "cp866",
                            );

                            printer.printCustom(
                                removeSpecialCharacters(
                                    "Хүлээлгэн өгсөн:................"),
                                1,
                                1,
                                charset: "cp866");

                            printer.printCustom(
                                removeSpecialCharacters(
                                    "Хүлээн авсан:................... "),
                                1,
                                1,
                                charset: "cp866");

                            printer.printNewLine();
                            printer.printNewLine();
                          } else {
                            Alert(
                              context: context,
                              title: "Алдаа",
                              desc: "Хэвлэгч холбосон эсэхээ шалгана уу.",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Тийм",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  width: 120,
                                ),
                              ],
                            ).show();
                          }
                        } catch (e) {
                          Alert(
                            context: context,
                            title: "Алдаа",
                            desc: "Хэвлэхэд алдаа гарлаа! " + e.toString(),
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Тийм",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 120,
                              ),
                            ],
                          ).show();
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.print,
                        size: 24.0,
                      ),
                      label: Text("Print"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
