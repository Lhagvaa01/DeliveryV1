// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_import, unnecessary_null_comparison

import 'dart:convert';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:deliery_app/Provider/add_to_cart.dart';
import 'package:deliery_app/Provider/customer_provider.dart';
import 'package:deliery_app/Provider/profile_provider.dart';
import 'package:deliery_app/Provider/transactions_provider.dart';
// import 'package:serial_reg/Screens/Report/Screens/sales_report_screen.dart';
// import 'package:serial_reg/Screens/Sales/sales_screen.dart';
import 'package:deliery_app/model/transition_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
// import '../../HTTP Post&Get/post_get.dart';
import '../../Provider/printer_provider.dart';
import '../../Provider/product_provider.dart';
import '../../Provider/seles_report_provider.dart';
import '../../constant.dart';
import '../../model/print_transaction_model.dart';
import '../../model/product_sold.dart';
import '../../model/search_serial.dart';
import '../CustomersOld/Model/customer_model.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

// ignore: must_be_immutable
class AddSalesScreen extends StatefulWidget {
  const AddSalesScreen({Key? key}) : super(key: key);

  // CustomerModel customerModel;

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  double paidAmount = 0;
  double discountAmount = 0;
  double returnAmount = 0;
  double dueAmount = 0;
  double subTotal = 0;

  String? dropdownValue = '';
  String? selectedPaymentType;
  List<String> dropdownPayment = [];
  TextEditingController txtSerial = TextEditingController();
  TextEditingController customerCon = TextEditingController();
  TextEditingController customerNote = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  List<SearchSerial> _gets = <SearchSerial>[];
  ProductSold prodctSold = ProductSold();
  int customerId = 0;

  FocusNode txtField = FocusNode();

  bool isLoading = false;
  bool isLoadingSer = false;

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectDevice;

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    selectDevice = BluetoothDevice('Device Name', 'Device Address');
    isTap = true;
    // getPaymentList(context).then((value) {
    //   setState(() {
    //     dropdownPayment = value;
    //     dropdownValue = dropdownPayment[0];
    //   });
    // });
    dateCon.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    isTap = false;
    super.dispose();
  }

  search(String serial) {
    setState(() {
      isLoadingSer = true;
    });
    // getSearchSerial(context, serial).then((value) {
    //   setState(() {
    //     isLoadingSer = false;
    //     if (value.state == "ready") {
    //       print(value.productId![1]);
    //       _gets.add(value);
    //       txtSerial.clear();
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(
    //             "Тухайн барааг борлуулах боломжгүй байна: " +
    //                 value.state.toString(),
    //           ),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   });
    // });
  }

  // String result = "Waiting QR Scan Text";
  Future _scanQR() async {
    // Logger log = getLogger("QrCodeScan");
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      // log.i(qrResult);
      setState(() {
        if (qrResult.rawContent != "") {
          // incomeBarcodesearch(qrResult.rawContent);
          setState(() {
            txtSerial.text = qrResult.rawContent;
            search(qrResult.rawContent);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Бар код уншигдсаншүй!",
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Camera permission denied",
              ),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Unkown error $ex",
              ),
              backgroundColor: Colors.green,
            ),
          );
        });
      }
    } on FormatException {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You pressed the back button before scanning anything",
            ),
            backgroundColor: Colors.orange,
          ),
        );
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Unkown error $e",
            ),
            backgroundColor: Colors.blue,
          ),
        );
      });
    }
  }

  List<int> retProductsId = [];
  int paymentId = 0;
  saveProduct() async {
    retProductsId = [];
    for (var element in _gets) {
      retProductsId.add(element.id!);
    }
    for (var element in getPaymentLists) {
      if (element.name!.contains(dropdownValue!)) {
        paymentId = element.id!;
      }
    }
    String body = saveBuid(retProductsId);
    await Future.delayed(const Duration(seconds: 3));
    // postProdctSold(context, body).then((value) {
    //   setState(() {
    //     isLoading = false;
    //     if (value == "ok") {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           duration: Duration(milliseconds: 1500),
    //           content: Text(
    //             "Амжилттай хадгалагдлаа.",
    //           ),
    //           backgroundColor: Colors.green,
    //         ),
    //       );
    //     }
    //   });
    // }).then((_) {
    //   Navigator.pop(context);
    //   Navigator.of(context).pushNamed('/${'addSale'}');
    // });
  }

  String saveBuid(List<int> val) {
    prodctSold = ProductSold(
      // cinfoId: 4,
      // // productId![1]: get.id,
      // changeId: "",
      // note: "",
      // state: "new",
      customerId: customerId,
      paymentId: paymentId,
      delivered: "Yes",
      note: customerNote.text,
      details: val,
    );
    return jsonEncode(prodctSold);
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Борлуулалт',
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: customerCon,
                      textFieldType: TextFieldType.NAME,
                      readOnly: true,
                      suffix: IconButton(
                        icon: Icon(
                          Icons.list,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/customersList',
                              arguments: {
                                'leading': false,
                                'isCustomer': true
                              }).then((_) {
                            customerCon.text = getCustomer.name.toString();
                            customerId = getCustomer.id!;
                          });
                        },
                      ),
                      // initialValue: widget.customerModel.customerName,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Салбар сонгох',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: dateCon,
                      readOnly: true,
                      // initialValue: transitionModel.purchaseDate,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Date',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              initialDate: selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101),
                              context: context,
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                                dateCon.text = DateFormat("yyyy-MM-dd")
                                    .format(selectedDate);
                                // transitionModel.purchaseDate =
                                //     selectedDate.toString();
                              });
                            }
                          },
                          icon: const Icon(
                            FeatherIcons.calendar,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: customerNote,
                textFieldType: TextFieldType.NAME,
                readOnly: false,
                // initialValue: widget.customerModel.customerName,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Гүйлгээний утга',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                focus: txtField,
                controller: txtSerial,
                autoFocus: true,
                onFieldSubmitted: (value) {
                  search(value);
                  FocusScope.of(context).requestFocus(txtField);
                },
                textFieldType: TextFieldType.NAME,
                decoration: const InputDecoration(
                    labelText: 'Барааны код', border: OutlineInputBorder()),
                suffix: GestureDetector(
                  onTap: _scanQR,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/barcode.png'),
                          fit: BoxFit.scaleDown),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // isLoadingSer
              //     ? Container(
              //         child: LoadingIndicator(text: "Түр хүлээнэ үү..."),
              //       )
              //     : Container(),

              ///_______Added_ItemS__________________________________________________
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  border: Border.all(width: 1, color: const Color(0xffEAEFFA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        )),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _gets.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  _gets.removeAt(index);
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.blue,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Сериал",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Нэр",
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
                                    Flexible(
                                      child: Text(
                                        _gets[index].serial.toString(),
                                        style: const TextStyle(fontSize: 16),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        _gets[index].productId![1].toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: const Color(0xffEAEFFA),
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(height: 20),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Төлбөрийн хэлбэр',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.wallet,
                          color: Colors.green,
                        )
                      ],
                    ),
                    DropdownButton(
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dropdownPayment.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Description',
                        hintText: 'Add Note',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade200),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              FeatherIcons.camera,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Image',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                      )),
                ],
              ).visible(false),
              Container(
                height: 50,
                width: size.width / 1.8,
                child: DropdownButton<BluetoothDevice?>(
                  style: TextStyle(
                    color: Colors.black,
                    // fontSize: txtFontSize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownColor: Colors.white,
                  value: selectDevice,
                  hint: Text(
                    'Хэвлэгчээ сонгоно уу',
                    style: TextStyle(
                      color: Colors.black,
                      // fontSize: txtFontSize + 4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onChanged: (BluetoothDevice? device) {
                    setState(() {
                      selectDevice = device;
                      print("selectDevice: $selectDevice");
                      // print(isConnectPrint.text);
                    });
                  },
                  items: devices
                      .map(
                        (e) => DropdownMenuItem<BluetoothDevice?>(
                          child: Text(e.name ?? 'Unknown Device'),
                          value: e,
                        ),
                      )
                      .toList(),
                ),
              ),

              !isLoading
                  ? ButtonGlobal(
                      iconWidget: Icons.print,
                      buttontext: 'Хэвлэх',
                      iconColor: Colors.white,
                      buttonDecoration:
                          kButtonDecoration.copyWith(color: kMainColor),
                      onPressed: () {
                        print("Hewleh");
                        // connectToPrinter();

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     duration: Duration(seconds: 1),
                        //     content: Text(
                        //       "Түр хүлээнэ үү!",
                        //     ),
                        //     backgroundColor: Colors.amber,
                        //   ),
                        // );

                        // if (customerId != 0) {
                        //   if (retProductsId != []) {
                        //     setState(() {
                        //       isLoading = true;
                        //     });
                        //     saveProduct();
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         duration: Duration(seconds: 2),
                        //         content: Text(
                        //           "Бараа уншуулаагүй байна!",
                        //         ),
                        //         backgroundColor: Colors.amber,
                        //       ),
                        //     );
                        //   }
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       duration: Duration(seconds: 2),
                        //       content: Text(
                        //         "Худалдан авагч сонгоно уу!",
                        //       ),
                        //       backgroundColor: Colors.amber,
                        //     ),
                        //   );
                        // }
                      },
                    )
                  : Container(
                      child: Text("Түр хүлээнэ үү..."),
                      // child: LoadingIndicator(text: "Түр хүлээнэ үү..."),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
