import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliery_app/GlobalComponents/button_global.dart';
import 'package:deliery_app/Provider/customer_provider.dart';
import 'package:deliery_app/Screens/CustomersOld/add_customer.dart';
import 'package:deliery_app/Screens/CustomersOld/customer_details.dart';
import 'package:deliery_app/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Customer List',
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(builder: (context, ref, __) {
          final providerData = ref.watch(customerProvider);

          return providerData.when(data: (customer) {
            return customer.isNotEmpty
                ? ListView.builder(
                    itemCount: customer.length,
                    itemBuilder: (_, index) {
                      customer[index].type == 'Retailer'
                          ? color = const Color(0xFF56da87)
                          : Colors.white;
                      customer[index].type == 'Wholesaler'
                          ? color = const Color(0xFF25a9e0)
                          : Colors.white;
                      customer[index].type == 'Dealer'
                          ? color = const Color(0xFFff5f00)
                          : Colors.white;
                      customer[index].type == 'Supplier'
                          ? color = const Color(0xFFA569BD)
                          : Colors.white;

                      return GestureDetector(
                        onTap: () {
                          CustomerDetails(
                            customerModel: customer[index],
                          ).launch(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: CircleAvatar(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                  radius: 70.0,
                                  child: ClipOval(
                                    child: Image.network(
                                      customer[index].profilePicture,
                                      fit: BoxFit.cover,
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer[index].customerName,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    customer[index].type,
                                    style: GoogleFonts.poppins(
                                      color: color,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$ ${customer[index].dueAmount}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    'Due',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFff5f00),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ).visible(customer[index].dueAmount != '' &&
                                  customer[index].dueAmount != '0'),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: kGreyTextColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      'Please Add A Customer',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  );
          }, error: (e, stack) {
            return Text(e.toString());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          });
        }),
      ),
      bottomNavigationBar: ButtonGlobal(
        iconWidget: Icons.add,
        buttontext: 'Add Customer',
        iconColor: Colors.white,
        buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
        onPressed: () {
          const AddCustomer().launch(context);
        },
      ),
    );
  }
}
