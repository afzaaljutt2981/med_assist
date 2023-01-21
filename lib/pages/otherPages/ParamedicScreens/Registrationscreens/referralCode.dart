import 'package:flutter/material.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:med_assist/services/widgets/text_fields.dart';

import '../../../../services/utils/app_text_style.dart';
import '../../../../services/widgets/PeramedicData/paramedicRegisterWidget.dart';
import '../registerScreen.dart';

class ReferralCode extends StatefulWidget {
  const ReferralCode({Key? key}) : super(key: key);
  @override
  State<ReferralCode> createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: AppColors.kSecondryColor,
       // Appbar
       appBar:  PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: ParamedicRegisterAppbar(screenName: "Referral Code",),
  ),
      
      
      //body 
      body: SingleChildScrollView(
       // physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
             SizedBox( height: screenHeight * 0.04),
          
             // Referral Container
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: Colors.white,
                           boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.12),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                  ),
                width: screenWidth*0.95,                        
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Center(child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("Enter your recruiter's referral code", style: AppTextStyles.popins(
                            style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontSize: 16,
                              
                            )
                      ), ),
                    )),
                     
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                       child: TextFieldClass(keyboardType: TextInputType.number,  ),
                     )
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
                      width: screenWidth * 0.87,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)))),
                        onPressed: () {
                          LoadingDialogue.showLoaderDialog(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) =>
                                  const ParamedicRegistrationScreen()));
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
         
       
             // term and conditions
             SizedBox(height: screenHeight*0.02,),
             Container(
                width: screenWidth * 0.85,
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(4)
              ),
              child:Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    // ignore: prefer_const_constructors
                    TextSpan(text: 'If you have questions, please contact our\n',style: AppTextStyles.popins(style: TextStyle(
                      color: AppColors.kDarkColor,
                      fontSize: 12
                    ))),
                    // ignore: prefer_const_constructors
                    TextSpan(text: 'customer support.', style: AppTextStyles.popins(style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 12.5,
                      decoration: TextDecoration.underline
                    ))),]) ,
                    textAlign: TextAlign.center
                    ,)
             ) 
             
             ,SizedBox(
              height: screenHeight*0.04,
             )
          ],
        ),
      ), 
       );
  }
}