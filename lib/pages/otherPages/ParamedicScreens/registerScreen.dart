import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/Registrationscreens/basicInfo.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/Registrationscreens/cnicVerfication.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/Registrationscreens/idConfirmation.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/Registrationscreens/referralCode.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import '../../../services/providers/peramedic/registerParamedic.dart';
import '../../../services/widgets/PeramedicData/paramedicRegisterWidget.dart';
import 'Registrationscreens/confirmationScreen.dart';
import 'Registrationscreens/documents.dart';

class ParamedicRegistrationScreen extends StatefulWidget {
  const ParamedicRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ParamedicRegistrationScreen> createState() =>
      _ParamedicRegistrationScreenState();
}

class _ParamedicRegistrationScreenState
    extends State<ParamedicRegistrationScreen> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ParamedicRegistration>(
      create: (context) => ParamedicRegistration(),
      child: Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        // AppBar
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ParamedicRegisterAppbar(
              screenName: "Registration",
            )),

        // Body
        body:  Consumer<ParamedicRegistration> (
          builder: (context, value, child) {
         return
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),

              //Paramedic info conatiner
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: screenWidth * 0.9,
                  child: Column(
                    children: [
                      paramedicInfo("Basic Info", onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  BasicInfo(

                                  fName: value.infoUser?.fname ?? "",
                                  lName: value.infoUser?.lName  ?? "",
                                  emal: value.infoUser?.email!  ?? "",

                                )));
                      }),
                      const Divider(
                        thickness: 1,
                      ),
                      paramedicInfo("ID Confirmation", onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IdConfirmation()));
                      }),
                      const Divider(
                        thickness: 1,
                      ),
                      paramedicInfo("CNIC", onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CnicVerfication()));
                      }),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: paramedicInfo("Documents", onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Documents()));
                        }),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: paramedicInfo("Agent Raferral Code", onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReferralCode()));
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              // Done Button
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color:Colors.grey.shade300,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            (value.count < (4))
                                ? Colors.grey.shade400
                                : AppColors.kPrimaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)))),
                    onPressed: () {
                      if (value.count < (4)) {
                        print("old${value.count}");
                        newSnackBar("Fill all information", context);
                        newSnackBar("Fill all information", context);
                      } else {
                        print("new${value.count}");
                        LoadingDialogue.showLoaderDialog(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>
                                const RegistrationConfirmationScreen()),
                                (route) => false);
                      }
                    },
                    child: Text(
                      "Done ",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  )),
           // doneButton(value, context),


              // Terms and conditions
              SizedBox(
                height: screenHeight * 0.02,
              ),
              termsAndConditions()
            ],
          );}
        ),
      ),
    );
  }

  Widget doneButton(RegisterPeramedic value, BuildContext context) {
    return Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color:Colors.grey.shade300,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          (value.count < (4) || value.count == null)
                              ? Colors.grey.shade400
                              : AppColors.kPrimaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
                  onPressed: () {
                    if (value.count < (4) || value.count == null) {
                      newSnackBar("Fill all information", context);
                    } else {
                      LoadingDialogue.showLoaderDialog(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  const RegistrationConfirmationScreen()),
                          (route) => false);
                    }
                  },
                  child: Text(
                    "Done ",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                ));
  }

  Widget termsAndConditions() {
    return SizedBox(
              width: screenWidth * 0.75,
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    // ignore: prefer_const_constructors
                    TextSpan(
                        text: 'By tapping «Submit» I agree with ',
                        style: AppTextStyles.popins(
                            style:const TextStyle(
                                color: AppColors.kDarkColor, fontSize: 10))),
                    // ignore: prefer_const_constructors
                    TextSpan(
                        text: 'Terms and Conditions,',
                        style: AppTextStyles.popins(
                            style:const TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 10.5,
                                decoration: TextDecoration.underline))),
                    // ignore: prefer_const_constructors
                    TextSpan(
                        text:
                            ' I acknowledge and agree with processing and transfer of personal data according to conditions of ',
                        style: AppTextStyles.popins(
                            style:const TextStyle(
                                color: AppColors.kDarkColor, fontSize: 10))),
                    // ignore: prefer_const_constructors
                    TextSpan(
                        text: 'Privacy Policy.',
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 10.5,
                                decoration: TextDecoration.underline))),
                  ],
                ),
                textAlign: TextAlign.center,
              ));
  }

// paramedic info container
  Widget paramedicInfo(String text, {String? subText, required Function() onTap,}) {
    return SizedBox(
      height: screenHeight * 0.051,
      child: ListTile(
        onTap: onTap,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Text(
            text,
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        trailing: const Padding(
          padding: EdgeInsets.only(bottom: 9),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  void newSnackBar(String text, BuildContext context) {
    final snackbaar = SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.black.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbaar);
  }
}
