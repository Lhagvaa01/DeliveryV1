// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_import, unnecessary_null_comparison, use_super_parameters, unrelated_type_equality_checks, sort_child_properties_last

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
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../GlobalComponents/button_global.dart';
// import '../../HTTP Post&Get/post_get.dart';
import '../../HTTP Post&Get/post_get.dart';
import '../../Provider/printer_provider.dart';
import '../../Provider/product_provider.dart';
import '../../Provider/seles_report_provider.dart';
import '../../constant.dart';
import '../../model/customers_model.dart';
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

  FocusNode txtField = FocusNode();

  bool isLoading = false;
  bool isLoadingSer = false;

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectDevice;

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  TextEditingController qtyTxt = TextEditingController();

  @override
  void initState() {
    selectDevice = BluetoothDevice('Device Name', 'Device Address');
    // totalPrice = 0.0;
    setState(() {});
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
    if (productList.isNotEmpty) {
      for (var product in productList) {
        if (product.itemCode == serial) {
          _gets.add(product);
          txtSerial.clear();
        }
      }
    } else {
      searchProduct(serial);
    }
    sumTotalPrice();
  }

  sumTotalPrice() {
    double tPrice = 0.0;
    for (var item in _gets) {
      tPrice += item.itemPrice.toDouble() * item.qty!;
    }
    totalPrice = tPrice;
  }

  searchProduct(String serial) {
    getSearchSerial(context, serial).then((value) {
      setState(() {
        isLoadingSer = false;
        if (value != []) {
          print(value.itemCode![1]);
          _gets.add(value);
          txtSerial.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Тухайн барааг борлуулах боломжгүй байна: " +
                    value.isActive.toString(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    });
  }

  List<HistoryProducts> retProductsId = [];
  int paymentId = 0;
  saveProduct() async {
    retProductsId = [];
    for (var element in _gets) {
      retProductsId.add(HistoryProducts(
        product: element.pk,
        quantity: element.qty,
      ));
    }
    String body = saveBuid(retProductsId.cast<HistoryProducts>());
    await Future.delayed(const Duration(seconds: 3));
    postProdctSold(context, body).then((value) {
      setState(() {
        isLoading = false;
        if (value == 'ok') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text(
                "Амжилттай хадгалагдлаа.",
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/${'addSale'}');
          Navigator.of(context).pushNamed('/printPage');
        }
      });
    });
    // .then((_) {
    //   Navigator.pop(context);
    //   Navigator.of(context).pushNamed('/${'addSale'}');
    //   Navigator.of(context).pushNamed('/printPage');
    // });

    setState(() {
      isLoading = false;
    });
  }

  CustomersListModel getFirstMainCustomer(
      List<CustomersListModel> customerList) {
    return customerList.firstWhere((customer) => customer.isMain == true);
  }

  String saveBuid(List<HistoryProducts> val) {
    // List<HistoryProduct> historyProducts = val.map((productId) {
    //   return HistoryProduct(product: productId, quantity: 10);
    // }).toList();

    prodctSold = ProductSold(
      userPk: loginInfo.user!.id,
      infoOutSector: getFirstMainCustomer(customerList).pk,
      infoToSector: customerId,
      totalPrice: totalPrice,
      description: customerNote.text,
      isIncome: true,
      historyProducts: val,
    );
    print(jsonEncode(prodctSold));

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
                            customerId = getCustomer.pk!;
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
                onChanged: (val) {
                  descText = val;
                },
              ),
              const SizedBox(height: 20),
              AppTextField(
                focus: txtField,
                controller: txtSerial,
                autoFocus: true,
                onFieldSubmitted: (value) async {
                  search(value);
                  FocusScope.of(context).requestFocus(txtField);
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    sumTotalPrice();
                  });
                },
                onChanged: (val) {
                  txtSerial.text = val;
                },
                suffix: IconButton(
                  icon: Icon(
                    Icons.list,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/productsList',
                            arguments: {'leading': false, 'isCustomer': true})
                        .then((_) {
                      // customerCon.text = getCustomer.name.toString();
                      // customerId = getCustomer.pk!;
                      if (getProduct != []) {
                        setState(() {
                          _gets.add(getProduct);

                          sumTotalPrice();
                        });
                      }
                    });
                  },
                ),
                textFieldType: TextFieldType.NAME,
                decoration: const InputDecoration(
                    labelText: 'Барааны код', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
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
                            onTap: () {
                              Alert(
                                context: context,
                                title: "Тоо хэмжээ:",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Болсон",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10 + 6),
                                    ),
                                    onPressed: () {
                                      _gets[index].qty = qtyTxt.text.toDouble();
                                      setState(() {
                                        sumTotalPrice();
                                      });
                                      Navigator.pop(context);
                                    },
                                    width: 120,
                                  ),
                                ],
                                content: TextField(
                                  controller: qtyTxt,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  autofocus: true,
                                  onSubmitted: (value) {
                                    _gets[index].qty = qtyTxt.text.toDouble();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              ).show();
                              // GestureDetector(
                              //   onTap: () {
                              //     qtyTxt.text = _gets[index]
                              //         .qty!
                              //         .toStringAsFixed(2)
                              //         .replaceAll(".00", "");
                              //     Alert(
                              //       context: context,
                              //       title: "Тоо хэмжээ:",
                              //       buttons: [
                              //         DialogButton(
                              //           child: Text(
                              //             "Болсон",
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 10 + 6),
                              //           ),
                              //           onPressed: () {
                              //             _gets[index].qty =
                              //                 qtyTxt.text.toDouble();
                              //             setState(() {
                              //               sumTotalPrice();
                              //             });
                              //             Navigator.pop(context);
                              //           },
                              //           width: 120,
                              //         ),
                              //       ],
                              //       content: TextField(
                              //         controller: qtyTxt,
                              //         keyboardType: TextInputType.number,
                              //         textAlign: TextAlign.center,
                              //         autofocus: true,
                              //         onSubmitted: (value) {
                              //           _gets[index].qty =
                              //               qtyTxt.text.toDouble();
                              //           setState(() {});
                              //           Navigator.pop(context);
                              //         },
                              //       ),
                              //     ).show();
                              //   },
                              //   child: Container(
                              //     height: 35,
                              //     width: 35,
                              //     alignment: Alignment.center,
                              //     decoration: BoxDecoration(
                              //       color: Colors.cyan,
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     child: FittedBox(
                              //       child: Text(
                              //         _gets[index].qty!.toStringAsFixed(2),
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //         ),
                              //         maxLines: 1,
                              //         textAlign: TextAlign.center,
                              //       ),
                              //     ),
                              //   ),
                              // );
                            },
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  _gets.removeAt(index);
                                  sumTotalPrice();
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
                                    // Text(
                                    //   "Барааны код",
                                    //   style: const TextStyle(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Flexible(
                                      child: Text(
                                        _gets[index].itemCode.toString(),
                                        style: const TextStyle(fontSize: 16),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Text(" | "),
                                    Flexible(
                                      child: Text(
                                        _gets[index].itemName!.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Үнэ",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                        _gets[index].itemPrice!.toString() +
                                            "₮",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Тоо/ш",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                        _gets[index].qty!.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
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
              Container(
                // color: kMainColor,
                width: size.width,
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Нийт дүн: ",
                      style: TextStyle(
                        fontSize: 20 + 2,
                      ),
                    ),
                    Text(
                      totalPrice.toString() + "₮",
                      style: TextStyle(
                        fontSize: 20 + 2,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
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

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              "Түр хүлээнэ үү!",
                            ),
                            backgroundColor: Colors.amber,
                          ),
                        );

                        salesProd = _gets;

                        if (customerId != 0) {
                          if (retProductsId != []) {
                            setState(() {
                              isLoading = true;
                            });
                            saveProduct();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  "Бараа уншуулаагүй байна!",
                                ),
                                backgroundColor: Colors.amber,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text(
                                "Худалдан авагч сонгоно уу!",
                              ),
                              backgroundColor: Colors.amber,
                            ),
                          );
                        }
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
