// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:delivery_app/Screens/Customers/new_customers.dart';
// import 'package:delivery_app/Screens/Home/home.dart';
// import 'package:delivery_app/Screens/Product/new_product.dart';
// import 'package:delivery_app/model/sales_history_hdr.dart';
// import 'package:mobile_pos/Screens/Authentication/forgot_password.dart';
// import 'package:mobile_pos/Screens/Authentication/login_form.dart';
// import 'package:mobile_pos/Screens/Authentication/otp_page.dart';
// import 'package:mobile_pos/Screens/Authentication/register_form.dart';
// import 'package:mobile_pos/Screens/Authentication/sign_in.dart';
// import 'package:mobile_pos/Screens/Authentication/success_screen.dart';
// import 'package:mobile_pos/Screens/Customers/customer_list.dart';
// import 'package:mobile_pos/Screens/Delivery/delivery_address_list.dart';
// import 'package:mobile_pos/Screens/Expense/expense_list.dart';
// import 'package:mobile_pos/Screens/Home/home.dart';
// import 'package:mobile_pos/Screens/Payment/payment_options.dart';
// import 'package:mobile_pos/Screens/Products/add_product.dart';
// import 'package:mobile_pos/Screens/Products/product_list.dart';
// import 'package:mobile_pos/Screens/Profile/profile_screen.dart';
// import 'package:mobile_pos/Screens/Purchase/purchase_contact.dart';
// import 'package:mobile_pos/Screens/Report/reports.dart';
// import 'package:mobile_pos/Screens/Sales/add_discount.dart';
// import 'package:mobile_pos/Screens/Sales/add_promo_code.dart';
// import 'package:mobile_pos/Screens/Sales/sales_contact.dart';
// import 'package:mobile_pos/Screens/Sales/sales_details.dart';
// import 'package:mobile_pos/Screens/Sales/sales_list.dart';
// import 'package:mobile_pos/Screens/Sales/sales_screen.dart';
// import 'package:mobile_pos/Screens/Sales/stock_list.dart';

import 'Screens/Auth/login.dart';
import 'Screens/Auth/success_screen.dart';
// import 'Screens/Customers/customers_list.dart';
// import 'Screens/Product/product_list.dart';
// import 'Screens/Repair History/repair_historyHdr.dart';
// import 'Screens/Repair History/repair_histrotyDtl.dart';
// import 'Screens/Repair/repair_screen.dart';
// import 'Screens/Return_Change/return_change.dart';
// import 'Screens/Sales/add_sales.dart';
// import 'Screens/SalesHistory/sales_historyDtl.dart';
// import 'Screens/SalesHistory/sales_historyHdr.dart';
import 'Screens/Sales/add_sales.dart';
import 'Screens/Sales/history_screens.dart';
import 'Screens/SalesHistory/sales_historyDtl.dart';
import 'Screens/SalesHistory/sales_historyHdr.dart';
import 'Screens/SplashScreen/on_board.dart';
import 'Screens/SplashScreen/splash_screen.dart';
// import 'Screens/history_screens.dart';

// import 'Screens/Authentication/profile_setup.dart';
// import 'Screens/Due Calculation/due_calculation_contact_screen.dart';
// import 'Screens/Products/update_product.dart';
// import 'Screens/Purchase/choose_supplier_screen.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("DataBase");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Deliver',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/onBoard': (context) => const OnBoard(),
        // '/signIn': (context) => const SignInScreen(),
        '/loginForm': (context) => LoginScreen(),
        // '/signup': (context) => const RegisterScreen(),
        // '/otp': (context) => const OtpPage(),
        // '/purchaseCustomer': (context) => const PurchaseContact(),
        // '/forgotPassword': (context) => const ForgotPassword(),
        '/success': (context) => const SuccessScreen(),
        // '/setupProfile': (context) => const ProfileSetup(),
        // '/home': (context) => const Home(),
        '/addSale': (context) => AddSalesScreen(),
        // '/productList': (context) => ProductList(),
        // '/newProduct': (context) => NewProduct(),
        // '/returnChange': (context) => ReturnChange(),
        // '/repairScreen': (context) => RepairScreen(),

        // '/customersList': (context) => CustomersList(),
        // '/newCustomer': (context) => NewCustomers(),
        '/salesHistoryHDR': (context) => SalesHistoryHDR(),
        '/salesHistoryDTL': (context) => SalesHistoryDTL(),
        '/historyScreens': (context) => HistoryScreens(),
        // '/repairHistoryHDR': (context) => RepairHistoryHDR(),
        // '/repairHistoryDTL': (context) => RepairHistoryDTL(),

        // '/profile': (context) => const ProfileScreen(),
        // // ignore: missing_required_param

        // '/AddProducts': (context) => AddProduct(),
        // '/UpdateProducts': (context) => UpdateProduct(),

        // '/Products': (context) => const ProductList(),
        // '/SalesList': (context) => const SalesScreen(),
        // // ignore: missing_required_param
        // '/SalesDetails': (context) => SalesDetails(),
        // // ignore: prefer_const_constructors
        // '/salesCustomer': (context) => SalesContact(),
        // '/addPromoCode': (context) => const AddPromoCode(),
        // '/addDiscount': (context) => const AddDiscount(),
        // '/Sales': (context) => SaleProducts(
        //       catName: 'Laptop',
        //     ),
        // '/Parties': (context) => const CustomerList(),
        // '/Expense': (context) => const ExpenseList(),
        // '/Stock': (context) => const StockList(),
        // '/Purchase': (context) => const PurchaseContacts(),
        // '/Delivery': (context) => const DeliveryAddress(),
        // '/Reports': (context) => const Reports(),
        // '/Due List': (context) => const DueCalculationContactScreen(),
        // '/PaymentOptions': (context) => const PaymentOptions(),
      },
    );
  }
}
