// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../HTTP Post&Get/post_get.dart';
import '../../constant.dart';
import '../../model/create_customers.dart';
import '../../model/customers_model.dart';
import '../loading_dialog.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({
    super.key,
  });

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  var _gets = <CustomersListModel>[];
  var _getsDisplay = <CustomersListModel>[];

  bool isLoading = true;
  @override
  void initState() {
    if (customerList.isNotEmpty) {
      isLoading = false;
      _getsDisplay = customerList;
    } else {
      getCustomersList(context).then((value) {
        setState(() {
          isLoading = false;
          print(value[0].createdDate);
          _gets.addAll(value);
          _getsDisplay = _gets;
        });
      });
    }

    super.initState();
  }

  clearField() {
    setState(() {
      searchField.clear();
    });
  }

  _listItem(index) {
    return ListTile(
      onTap: () {
        if (isTap) {
          getCustomer = _getsDisplay[index];
          Navigator.pop(context);
        }
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Салбар нэр",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Утас",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getsDisplay[index].name.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                _getsDisplay[index].phone.toString(),
                style: const TextStyle(fontSize: 16),
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
  }

  TextEditingController searchField = TextEditingController();
  var arg;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      arg = ModalRoute.of(context)!.settings.arguments as Map;
    }
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Харилцагчийн бүртгэл"),
        automaticallyImplyLeading: arg != null ? arg['leading'] : true,
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
                      image: AssetImage('images/parties1.png'),
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
                      labelText: 'Хайлт', border: OutlineInputBorder()),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      _getsDisplay = _gets.where((CustomersListModel) {
                        var postName = CustomersListModel.name!.toLowerCase();
                        // var postCode = CustomersListModel.ttd!.toLowerCase();
                        print(text);

                        return postName.contains(text);
                      }).toList();
                    });
                  },
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 203, 213, 235)),
                  ),
                  child: isLoading
                      ? Container(
                          child: LoadingIndicator(text: "Түр хүлээнэ үү..."),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _getsDisplay.length,
                          itemBuilder: (context, index) {
                            return _listItem(index);

                            // return ListTile(
                            //   onTap: () {
                            //     getCustomer = _gets[index];
                            //     Navigator.pop(context);
                            //   },
                            //   title: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //             "Харилцагч РД:",
                            //             style: const TextStyle(fontSize: 14),
                            //           ),
                            //           Text(
                            //             _gets[index].ttd.toString(),
                            //             style: const TextStyle(fontSize: 14),
                            //           ),
                            //         ],
                            //       ),
                            //       const SizedBox(height: 10),
                            //       Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //             "Харилцагч нэр:",
                            //             style: const TextStyle(fontSize: 14),
                            //           ),
                            //           Text(
                            //             _gets[index].name.toString(),
                            //             style: const TextStyle(fontSize: 14),
                            //           ),
                            //         ],
                            //       ),
                            //       const SizedBox(height: 5),
                            //       Container(
                            //         height: 1,
                            //         width: double.infinity,
                            //         color: const Color(0xffEAEFFA),
                            //       )
                            //     ],
                            //   ),
                            // );
                          }),
                ),
              ),
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
