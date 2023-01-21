import 'package:flutter/material.dart';

import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
import 'RulesAppBar.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PatientRulesAppbar(
            text: "Terms and conditions",
          )),


      body: ScrollConfiguration(behavior:const MaterialScrollBehavior().copyWith(overscroll: false) , child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: Text("PRIVACY POLICY",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                              color: AppColors.kDarkColor, fontSize: 22)), ),
              ),
            ),
          
Text('''Welcome to MedAssist. We are committed to protecting your privacy. This policy describes our privacy practices, the personal information we collect, how we use and share it, as well as your choices and rights regarding this information.   

This Privacy Policy applies to our Services wherever we provide them, and we will comply with local laws in relation to all practices described in this policy.  If there is an inconsistency between this policy and the local law, we will comply with the local law to the extent of the inconsistency.

MedAssist is provided and controlled by the entity indicated in the Terms of Use applicable to your country of residence (“we” or “us”). 

This policy applies to all MedAssist users, including users of our website, https://MedAssist.com/ (“Website”), any of the MedAssist mobile applications (“Apps”), and any services we provide through the Website or Apps, as well as when you contact us via telephone, email, written correspondence, social media, in-person, or any other means of contact (collectively, “Services”). This policy does not cover how we handle information that we collect about our employees or business associates, including our corporate partners, vendors, and subcontractors, but does apply to our Drivers.

In this policy individuals who utilize our Services are referred to as “Users.” Users that request or receive transportation are referred to as “Riders” and individuals who provide transportation to Riders are referred to as “Drivers.” Capitalized terms that are not defined in this policy have the meaning given to them in the Terms of Use.  If you accept the Terms of Use you agree to us dealing with your information in the way described in this policy.

Information you provide

Registration and profile information, such as your name, phone number, email, country, city, preferred language, profile picture. Where permitted or required by law, we may collect emergency contact numbers.

Driver's information, which may include driver's license data and status, information about the vehicle (type, make, model, year of manufacture, color, registration certificate data, license plate, vehicle inspection report, vehicle photo), ID document data (including driver license, passport, state identification numbers), proof of identity, proof of residency, physical address, date of birth, taxation identifier number, relevant insurance, right to work, driving record, payment or banking information, and other documents which may be required by applicable regulations. Where permitted or required by law, we may conduct identity verification and/or background check. This may require collecting and processing such information as your photograph, ID document data, social security number and criminal record. This information may be processed by vendors on our behalf.

User generated content that you choose to upload through the Services, such as comments, ratings, and reviews for other Users.

Information in correspondence you send to us, which may include chat messages, emails, and recordings of phone calls you make to us.
 

Information we collect automatically

Location information. We collect Users' location data to enable services, for user support, for safety and fraud detection purposes, and to satisfy legal requirements. We collect location information (including GPS coordinates and WiFi data) based on your App settings, device permissions, and whether you are using the App as a patient or a Paramedic (where applicable):


When you use MedAssist, you are agreeing to the most recent terms of this policy.

 
Contact
Questions, comments and requests regarding this policy should be addressed to: support@medassist.com.


''',style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kDarkColor, fontSize: 12)), )
          
          ],
        ),
      )),   
    );
  }
}