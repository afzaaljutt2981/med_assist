import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/homeScreen.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/pages/otherPages/NameDetailsScreen.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';

class Selectionscreen extends StatefulWidget {
  Selectionscreen({Key? key, this.phoneNmber}) : super(key: key);
  String? phoneNmber;

  @override
  State<Selectionscreen> createState() => _SelectionscreenState();
}

class _SelectionscreenState extends State<Selectionscreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        body: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Are u a paramedi or patient text
                SizedBox(
                  height: screenHeight * 0.045,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 7, right: 7),
                  child: Text(
                    "Are you a paramedic or a patient?",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 27,
                            fontWeight: FontWeight.w700)),
                  ),
                ),

                // Are u a paramedi or patient text
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 7, right: 7),
                  child: Text(
                    "You can change the mode later",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kDarkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  ),
                ),

                // Seection Picture
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 55),
                  child: Image(
                      image: AssetImage(
                          "assets/images/selectionScreen/selectionPic.png")),
                ),

                // Selection Button(patient)
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                Center(
                  child: Container(
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
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => NameDetailsScreen()),
                              (route) => true);
                          // Navigator.push(context, MaterialPageRoute(builder: (c)=>NameDetailsScreen() ));
                        },
                        child: Text(
                          "Patient",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )),
                ),

                // Selection Button(paramedic)
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Center(
                  child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: AppColors.kWhiteColor,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.kWhiteColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NameDetailsScreen()));
                        },
                        child: Text(
                          "Paramedic",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
