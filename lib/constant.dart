import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/customers_model.dart';
import 'model/login_info.dart';
import 'model/payment_list.dart';

// const kMainColor = Color(0xFF3F8CFF);
const kMainColor = Color(0xFF01aded);
const kGreyTextColor = Color(0xFF828282);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFF1F7F7);

LoginInfo loginInfo = LoginInfo();

List<String> paymentsTypeList = ['Буцаалт', 'Солилт'];

List<PaymentList> getPaymentLists = <PaymentList>[];
CustomersListModel getCustomer = CustomersListModel();

List<String> dropdownValues = ['Cash', 'Card', 'Check', 'Mobile Pay'];
const kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(5),
  ),
);

String startDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
String endDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

String shistoryDtlId = "";
String rHistoryDtlId = "";
String aProductId = "";
String aProductName = "";

bool isTap = false;

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(1.0),
    borderSide: const BorderSide(color: kBorderColorTextField),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

List<String> businessCategory = [
  'Fashion Store',
  'Electronics Store',
  'Computer Store',
  'Vegetable Store',
  'Sweet Store',
  'Meat Store'
];
List<String> language = [
  'English',
  'Bengali',
  'Hindi',
  'Urdu',
  'French',
  'Spanish'
];

List<String> productCategory = [
  'Fashion',
  'Electronics',
  'Computer',
  'Gadgets',
  'Watches',
  'Cloths'
];

List<String> userRole = [
  'Super Admin',
  'Admin',
  'User',
];

List<String> paymentType = [
  'Cheque',
  'Deposit',
  'Cash',
  'Transfer',
  'Sales',
];
List<String> posStats = [
  'Daily',
  'Monthly',
  'Yearly',
];
List<String> saleStats = [
  'Weekly',
  'Monthly',
  'Yearly',
];

List<String> loginImg = [
  "images/men_i.png",
  "images/women_i.png",
];

List<String> profileGender = [
  'Эр',
  'Эм',
];
