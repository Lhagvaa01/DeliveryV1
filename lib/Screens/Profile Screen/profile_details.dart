// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:serial_reg/GlobalComponents/button_global.dart';
// import 'package:serial_reg/Screens/Authentication/login_form.dart';
import 'package:deliery_app/Screens/Profile%20Screen/edit_profile.dart';
import 'package:nb_utils/nb_utils.dart';

// import '../../Provider/profile_provider.dart';
import '../../GlobalComponents/button_global.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../model/personal_information_model.dart';
import '../Auth/otp_page.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late String dropdownValue;

  @override
  initState() {
    dropdownValue = loginInfo.user!.username.toString();
    super.initState();
  }

  DropdownButton<String> getCategory(String category) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String category in profileGender) {
      var item = DropdownMenuItem(
        value: category,
        child: Text(category),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: category,
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        // AsyncValue<PersonalInformationModel> userProfileDetails =
        //     ref.watch(profileDetailsProvider);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          dropdownValue == "Эр" ? loginImg[0] : loginImg[1],
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextField(
                    initialValue: loginInfo.user!.username,
                    onChanged: (value) {
                      setState(() {
                        loginInfo.user!.username = value;
                      });
                    }, // Optional
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                        labelText: 'Нэр', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextField(
                    initialValue: loginInfo.user!.email,
                    onChanged: (value) {
                      setState(() {
                        loginInfo.user!.email = value;
                      });
                    }, // Optional
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                        labelText: 'Мэйл Хаяг', border: OutlineInputBorder()),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: SizedBox(
                //     height: 60.0,
                //     child: FormField(
                //       builder: (FormFieldState<dynamic> field) {
                //         return InputDecorator(
                //           decoration: InputDecoration(
                //               floatingLabelBehavior:
                //                   FloatingLabelBehavior.always,
                //               labelText: 'Хүйс',
                //               labelStyle: TextStyle(
                //                 fontSize: 20.0,
                //               ),
                //               border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(5.0))),
                //           child: DropdownButtonHideUnderline(
                //             child: getCategory(dropdownValue),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // ButtonGlobal(
                //   iconWidget: Icons.arrow_forward,
                //   buttontext: 'Нууц Үг Солих',
                //   iconColor: Colors.white,
                //   buttonDecoration:
                //       kButtonDecoration.copyWith(color: kMainColor),
                //   onPressed: () {
                //     // EasyLoading.show(status: 'Sending Email', dismissOnTap: false);
                //     OtpPage().launch(context);
                //     // EasyLoading.showSuccess('Email Sent! Check your Inbox');
                //   },
                // ),
                ButtonGlobal(
                  iconWidget: Icons.save,
                  buttontext: 'Хадгалах',
                  iconColor: Colors.white,
                  buttonDecoration:
                      kButtonDecoration.copyWith(color: kMainColor),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
