import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/RulesAndTerms/RulesAppBar.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/RulesAndTerms/privacyPolicy.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/RulesAndTerms/termsAndConditionsScreen.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';

import 'RulesAppBar.dart';

class RulesAndTerms extends StatefulWidget {
  const RulesAndTerms({Key? key}) : super(key: key);

  @override
  State<RulesAndTerms> createState() => _RulesAndTermsState();
}

class _RulesAndTermsState extends State<RulesAndTerms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
    preferredSize: const Size.fromHeight(55),
    child: ParamedicRulesAppbar( text: "Rules and terms", )
  ),
      
     body: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
       child: Column(
        children: [
          const SizedBox(height: 10,),
         rulesCatagories("Service rules",onTap: (){},"" ),
         rulesCatagories("Terms and Conditions", onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const ParamedicTermsAndConditions() ));
         },""),
         rulesCatagories("Privacy Policy", onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (c)=> const PrivacyAndPolicy() ));
         },""),
         rulesCatagories("Licenses", onTap: (){},""  ),
         rulesCatagories("App versions", onTap: (){},"0.01.1(12)" )
        ],
       ),
     ),
      
    );
  }

Widget rulesCatagories( String text, String? subText, {required Function() onTap, }  ){
  return     ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical:5),
              child: Text(text ,style: AppTextStyles.popins(
              style:  const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 18,
                
              )
          ), ),
            ),
          onTap: onTap,
          subtitle: Text( subText!,style: AppTextStyles.popins(
              style:  const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 14,
                
              )),
  ));
}

}
