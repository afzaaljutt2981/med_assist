import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:med_assist/pages/authScreens/phoneVerification.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../services/models/PatientModels/homeScreenModels/drowerProfileModel.dart';
import 'NameDetailsScreen.dart';

class MySplashscreen extends StatefulWidget {
  const MySplashscreen({Key? key, }) : super(key: key);
  @override
  State<MySplashscreen> createState() => _MySplashscreenState();
} 

class _MySplashscreenState extends State<MySplashscreen> {
  splashServices() {
    final auth = FirebaseAuth.instance;
    final currentUserData = auth.currentUser;
      Timer(
        const Duration(seconds: 4),
        () async {
          if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PhoneVerfication(),
          ));
    }
        }
      );
  }

  @override
  void initState() {
    super.initState();
    splashServices();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  ChangeNotifierProvider<RegisterPeramedic> (
      create: (context) => RegisterPeramedic(),
      child: Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.3,
                width: screenWidth * 0.55,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo/logo.png"))),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const SpinKitCircle(
                  duration: Duration(seconds: 2),
                  size: 60,
                  color: AppColors.kPrimaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
