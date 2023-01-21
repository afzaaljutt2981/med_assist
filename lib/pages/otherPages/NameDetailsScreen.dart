import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/authScreens/phoneVerification.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:med_assist/services/widgets/text_fields.dart';
import 'package:provider/provider.dart';

import '../../services/providers/RegisterUser.dart';
import '../authScreens/otpVerification.dart';

class NameDetailsScreen extends StatefulWidget {
  NameDetailsScreen({Key? key,}) : super(key: key);

  @override
  State<NameDetailsScreen> createState() => _NameDetailsScreenState();
}

final _formkey = GlobalKey<FormState>();

class _NameDetailsScreenState extends State<NameDetailsScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      body: ChangeNotifierProvider(
        create: (context) => RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
            builder: (BuildContext context, value, Widget? child) {
          return Form(
            key: _formkey,
            child: Container(
              padding: MediaQuery.of(context).padding,
              margin: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),

                    // Back arrow text
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              //  Navigator.push(context, MaterialPageRoute(builder: (c)=>  OtpVerification( ) ));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.kPrimaryColor,
                            )),
                        Text(
                          "back",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kDarkColor, fontSize: 16)),
                        )
                      ],
                    ),

                    // Welcome text
                    SizedBox(
                      height: screenHeight * 0.08,
                    ),
                    Text(
                      "Welcome to MED Assist!",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                    ),

                    // lets get acquainted text
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 7, right: 7),
                      child: Text(
                        "Let’s get acquainted",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kDarkColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),

                    // Text Fields
                    SizedBox(height: screenHeight * 0.1),
                    TextFieldClass(
                      hinText: "First Name",
                      fieldController: firstName,
                      validate: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[A-Z]+$').hasMatch(value)) {
                          return "required username";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextFieldClass(
                      hinText: "Last Name",
                      fieldController: lastName,
                      validate: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[A-Z]+$').hasMatch(value)) {
                          return "required username";
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Next Button
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.kPrimaryColor,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () async {

                            if (_formkey.currentState!.validate()) {


                              LoadingDialogue.showLoaderDialog(context);
                             _formkey.currentState!.save();

                        await value.registerUser (firstName , lastName, );

                          // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const HomeScreen()),
                                  (route) => false);
                            }
                          },
                          child: Text(
                            "NEXT",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
