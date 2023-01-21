import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/pages/otherPages/chat_screen.dart';
import 'package:med_assist/pages/otherPages/selectionScreen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../services/providers/RegisterUser.dart';
import '../../services/utils/app_text_style.dart';
import '../../services/utils/colors.dart';
import '../otherPages/NameDetailsScreen.dart';

class OtpVerification extends StatefulWidget {
  String? phoneNumber;
  OtpVerification({Key? key, this.phoneNumber}) : super(key: key);
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController _pinputConroller = TextEditingController();
  FocusNode focusNode = FocusNode();
  late String verificationCode;
  @override
  initState() {
    super.initState();
    verifyPhone();
    startTimer();
  }

  int start = 60;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child:
             Scaffold(
              backgroundColor: AppColors.kSecondryColor,
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Padding(
                        padding: const EdgeInsets.only(top: 70, bottom: 40),
                        child: SizedBox(
                          // color: Colors.red,
                          width: screenWidth,
                          height: screenHeight * 0.18,
                          child: const Image(
                              image: AssetImage("assets/images/logo/logo.png")),
                        ),
                      ),
           
                      // text verification
                      Text(
                        "Verification ",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kPrimaryColor)),
                      ),
           
                      // Verification Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Please enter six digit verification code that we have sent to ",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kDarkColor,
                          )),
                        ),
                      ),
           
                      // number Text
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Text(
                        "+92 ${widget.phoneNumber} ",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kDarkColor,
                        )),
                      ),
           
                      // pInput
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Pinput(
                          controller: _pinputConroller,
                          focusNode: focusNode,
                          keyboardType: TextInputType.number,
                          length: 6,
                          onCompleted: (value) async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(PhoneAuthProvider.credential(
                                      verificationId: verificationCode,
                                      smsCode: value))
                                  .then((value) {
           
                                if (value.user != null) {
           
                                  selectionServices();
                                } else {
                                  Navigator.of(context).pop();
                                  newSnackBar(context);
                                }
                              });
                            } catch (e) {
                              Navigator.of(context).pop();
           
                              FocusScope.of(context).unfocus();
                              newSnackBar(context);
                              print(e);
                            }
                          },
                        ),
                      ),
           
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: showTimer()),
           
                      // Rich Text Resend Code
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: "Didn't receive code? ",
                              style: AppTextStyles.popins(
                                style: const TextStyle(
                                  color: AppColors.kDarkColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    text: "Resend",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ))),
                              ])),
           
                      SizedBox(
                        height: screenHeight * 0.09,
                      ),
                    ],
                  ),
                ),
              ),
                     )
             );
      

  }

  Widget showTimer() {
    return RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: "send OTP again in ",
            style: AppTextStyles.popins(
              style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 12,
              ),
            ),
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      verifyPhone();
                      Navigator.of(context).pop();
                    },
                  text: "00:$start",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 12,
                  ))),
              TextSpan(
                text: " sec",
                style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ]));
  }

  selectionServices( ) async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await userRef.get().then((value) {
      if(!(value.exists)){
           register();
       //  valueOfModel.registerUser ( textEditingController.text , "" ,"" , "", "", "", FirebaseAuth.instance.currentUser!.uid );
           Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (c) => Selectionscreen(
                      phoneNmber: widget.phoneNumber,
                    )),
            (route) => false);
     
       }
       else{
                  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (c) => const HomeScreen ()),
                (route) => false);
       }
      // if (value.exists) {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (c) => const HomeScreen ()),
        //         (route) => false);
      //   // Navigator.pushAndRemoveUntil(context,
      //   //     MaterialPageRoute(builder: (c) => CheckUser(provider:model.user!, num: widget.phoneNumber  )), (route) => false);
      // } else {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (c) => Selectionscreen(
        //               phoneNmber: widget.phoneNumber,
        //             )),
        //     (route) => false);
      // }
    });
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+92${widget.phoneNumber}',
        verificationCompleted:
            ((PhoneAuthCredential phoneAuthCredential) async {
          await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential)
              .then((value) async {
            if (value.user != null) {
              print('user logged in');
              // Navigator.push(context, MaterialPageRoute(builder: (c)=>  PatientNameDetails(phoneNumber: widget.phoneNumber,)   ),);
            } else {
              newSnackBar(context);
            }
          });
        }),
        verificationFailed: ((error) {
          print(error.message);
        }),
        codeSent: ((String verificationId, forceResendingToken) {
          //  if (!mounted) {
          //     return;
          //   }
          setState(() {
            verificationCode = verificationId;
            print('verification code');
            print(verificationCode);
          });
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
           if (!mounted) {
              return;
            }
          setState(() {
            verificationCode = verificationId;
          });
        }),
        timeout: const Duration(seconds: 30));
  }

  void newSnackBar(BuildContext context) {
    final snackbaar = SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.black.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: const Text("Invalid otp"));
    ScaffoldMessenger.of(context).showSnackBar(snackbaar);
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        if (!mounted) {
          return;
        }
        setState(() {
          start--;
        });
      }
    });
  }

register() async {
  await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "firstName": "",
      "lastName": "",
      "phoneNumber": widget.phoneNumber,
      "id": FirebaseAuth.instance.currentUser!.uid,
      "profilePic": "",
      "email": "",
      
  });
}
}
