import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';

class EditPatientNumber extends StatefulWidget {
  const EditPatientNumber({Key? key}) : super(key: key);

  @override
  State<EditPatientNumber> createState() => _EditPatientNumberState();
}

class _EditPatientNumberState extends State<EditPatientNumber> {
  bool isNumber = false;
  late String verificationCode;
  TextEditingController editNumberController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // AppBar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.kPrimaryColor,
        ),
        backgroundColor: AppColors.kSecondryColor,
        title: Text(
          "Phone number",
          style: AppTextStyles.popins(
              style: const TextStyle(
                  color: AppColors.kDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
      ),

      // body
      body: Form(
        key: _formkey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Your account and data will be linked to the new number",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                    color: AppColors.kDarkColor,
                  )),
                ),

                // Text Field
                SizedBox(
                  height: 0.2,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.toString().length < 10) {
                          return "  please provide a valid number";
                        } else {
                          return null;
                        }
                      },
                      controller: editNumberController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          enabled: true,
                          hintText: "Enter your phone number",
                          hintStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                // Pinput
                !isNumber
                    ? Container(
                        height: 50,
                        color: AppColors.kSecondryColor,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                                "Enter OTP sent to +92-${editNumberController.text}"),
                            Pinput(
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
                                        .signInWithCredential(
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    verificationCode,
                                                smsCode: value))
                                        .then((value) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc()
                                          .update(
                                        {
                                          "phoneNumber":
                                              editNumberController.text
                                        },
                                      );

                                      Navigator.of(context).pop();
                                    });
                                  } catch (e) {
                                    Navigator.of(context).pop();

                                    FocusScope.of(context).unfocus();
                                    print("object");
                                    newSnackBar(context);
                                    print(e);
                                  }
                                }),
                          ],
                        ),
                      ),

                // Next Button
                SizedBox(
                  height: screenHeight * 0.5,
                ),

                isNumber
                    ? Container()
                    : Container(
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
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              verifyPhone();
                              setState(() {
                                isNumber = !isNumber;
                              });
                            }
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpVerification() ));
                          },
                          child: Text(
                            "Get OTP",
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
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+92${editNumberController.text}',
        verificationCompleted:
            ((PhoneAuthCredential phoneAuthCredential) async {
          await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential)
              .then((value) async {});
        }),
        verificationFailed: ((error) {
          print(error.message);
        }),
        codeSent: ((String verificationId, forceResendingToken) {
          setState(() {
            verificationCode = verificationId;
          });
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
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
}
