import 'package:country_phone_code_picker/core/country_phone_code_picker_widget.dart';
import 'package:country_phone_code_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/pages/authScreens/otpVerification.dart';
import '../../services/utils/app_text_style.dart';
import '../../services/utils/colors.dart';

class PhoneVerfication extends StatefulWidget {
  const PhoneVerfication({Key? key}) : super(key: key);

  @override
  State<PhoneVerfication> createState() => _PhoneVerficationState();
}

class _PhoneVerficationState extends State<PhoneVerfication> {
  TextEditingController numberController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  get screenWidth => MediaQuery.of(context).size.width;
  get screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.kSecondryColor,
          body: Form(
            key: _formkey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    // Logo
                    logoImage(),

                    // Signin & welcome Text
                    signInText(),
                    welcomeText(),

                    SizedBox(
                      height: screenHeight * 0.12,
                    ),

                    // text fileds of number
                    numberTextField(),

                    // Next ButtonSizedBox(height: screenHeight *0.04,)
                    submitButton(),

                    // Terms and Conditions
                    SizedBox(height: screenHeight * 0.2),
                    termsAndConditions()
                  ],
                ),
              ),
            ),
          )),
    );
  }

/* -----------------------------------
                  WIDGETS
  -------------------------------------*/

// logo image
  Widget logoImage() {
    return SizedBox(
      // color: Colors.red,
      width: screenWidth * 0.44,
      height: screenHeight * 0.25,
      child: const Image(image: AssetImage("assets/images/logo/logo.png")),
    );
  }

// signin Text
  Widget signInText() {
    return Text(
      "Sign in",
      style: AppTextStyles.popins(
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimaryColor)),
    );
  }

// Welcome Text
  Widget welcomeText() {
    return // Welcome Text
        Text(
      "Welcome to MED Assist",
      style: AppTextStyles.popins(
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.kDarkColor)),
    );
  }

// Number text field
  Widget numberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 0, bottom: 17),
      child: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.08,
        child: Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.3,
                child: CountryPhoneCodePicker.withDefaultSelectedCountry(
                  defaultCountryCode: Country(
                      name: 'Pakistan', countryCode: 'PK', phoneCode: ' +92'),
                  flagWidth: 40,
                  style: const TextStyle(fontSize: 18),
                  searchBarHintText: 'Search by name',
                  showPhoneCode: true,
                ),
              ),
              Expanded(
                  child: TextFormField(
                validator: (value) {
                  if (value!.toString().length < 10) {
                    return "  please provide a valid number";
                  } else {
                    return null;
                  }
                },
                controller: numberController,
               // maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    enabled: true,
                    hintText: "Enter your phone number",
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ))
            ],
          ),
        ),
      ),
    );
  }

// Next button
  Widget submitButton() {
    return Container(
        height: screenHeight * 0.063,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kPrimaryColor,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              _formkey.currentState!.save();

              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => OtpVerification(
                            phoneNumber: numberController.text,
                          )));
            }
          },
          child: Text(
            "Get OTP",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ));
  }

// terms & conditions
  Widget termsAndConditions() {
    return Container(
      width: screenWidth * 0.7,
      margin: const EdgeInsets.only(top: 17),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "By continuing, you are agreeing our ",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                color: AppColors.kDarkColor,
              )),
              children: [
                TextSpan(
                  text: " Terms, Conditions & Services.",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w700)),
                ),
              ])),
    );
  }
}
