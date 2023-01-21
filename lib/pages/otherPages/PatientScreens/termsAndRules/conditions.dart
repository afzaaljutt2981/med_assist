import 'package:flutter/material.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';

import 'RulesAppBar.dart';

class ParamedicTermsAndConditions extends StatelessWidget {
  const ParamedicTermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PatientRulesAppbar(
            text: "Terms and conditions",
          )),
      body: ScrollConfiguration(
        behavior:  const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "MED Assist Terms of Use",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kDarkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '''
      These terms of service constitute an agreement (the “Agreement”) between you and MedAssist (MED Assist, “we,” “us” or “our”) governing your use of the medAssist application, website. 
      ''',
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kDarkColor, fontSize: 12)),
                ),
              ),
              Text(
                "1. Accepting Terms of Use",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "1.1. IMPORTANT: BY USING THIS SERVICE, YOU AGREE THAT YOU HAVE READ, UNDERSTOOD, ACCEPTED AND AGREED WITH THESE TERMS AND CONDITIONS. YOU FURTHER AGREE TO THE REPRESENTATIONS MADE BY YOURSELF BELOW. IF YOU DO NOT AGREE TO OR FALL WITHIN THE TERMS OF USE OF THE SERVICE (AS DEFINED BELOW) AND WISH TO DISCONTINUE USING THE SERVICE, PLEASE DO NOT CONTINUE USING THIS APPLICATION OR SERVICE.",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kDarkColor, fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '1.2. The terms of use stated herein (collectively, the “Terms of Use” or this “Agreement”) constitute a legal agreement between you and MedAssist and its subsidiaries and affiliates (MedAssist). In order to use the Service (as defined below), you must agree to the Terms of Use that are set out below. By using the mobile applications and websites supplied to you by MedAssist (the “Application” or “App”), and downloading, installing or using any associated software supplied by MedAssist (the “Software”), you hereby expressly acknowledge and agree to be bound by the Terms of Use, and any future amendments and additions to this Terms of Use as published from time to time through the Application. By installing the MedAssist on your mobile device or computer, you thereby unconditionally agree with all the rules, conditions and information posted in the MedAssist application itself and on website, including but not limited to: this Terms of use, privacy policy, as well as the guidelines of use of the mobile application "MedAssist".',
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kDarkColor, fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '1.3. MedAssist reserves the right to modify, vary and change the Terms of Use or its policies relating to the Service at any time as it deems fit. Such modifications, variations and or changes to the Terms of Use or its policies relating to the Service shall be effective upon the posting of an updated version at the Application. You agree that it shall be your responsibility to review the Terms of Use regularly and also the Terms of Use applicable to any country where you use the Service whereupon the continued use of the Service after any such changes, whether or not reviewed by you, shall constitute your consent and acceptance to such changes. You further agree that usage of the Service in the Alternate Country shall be subject to the Terms of Use prevailing for the Alternate Country which can be found at Application.',
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                          color: AppColors.kDarkColor, fontSize: 12)),
                ),
              ),
              Text('2. Eligibility' ,style: AppTextStyles.popins(
                style: const TextStyle(
                  color: AppColors.kDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                )
              ),  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                    '2.1. By using the Service, you expressly represent and warrant that you are legally entitled to accept and agree to the Terms of Use and that you are at least eighteen (18) years old. Without limiting the generality of the foregoing, the Service is not available to persons under the age of eighteen (18) or such persons that are forbidden for any reason whatsoever to enter into a contractual relationship. By using the Service, you further represent and warrant that you have the right, authority and capacity to use the Service and to abide by the Terms of Use. You further confirm that all the information which you provide shall be true and accurate. Your use of the Service is for your own sole, personal use. You undertake not to authorize others to use your identity or user status, and you may not assign or otherwise transfer your user account to any other person or entity. When using the Service you agree to comply with all applicable laws whether in your home nation or otherwise in the country, state and city in which you are present while using the Service.',style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                    
                    fontSize: 12
                  )
                ),  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                    '2.2. You may only access the Service using authorized means. It is your responsibility to check and ensure that you have downloaded the correct Software for your device. MedAssist is not liable if you do not have a compatible device or if you have downloaded the wrong version of the Software to your device. MedAssist reserves the right not to permit you to use the Service should you use the Application and/or the Software with an incompatible or unauthorized device or for purposes other than which the Software and/or the Application is intended to be used.' ,style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                    
                    fontSize: 12
                  )
                ),  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                    'If you have any questions about the quality of the Service please contact us by email: info@medassist.com.',style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                    
                    fontSize: 12
                  )
                ),   ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
