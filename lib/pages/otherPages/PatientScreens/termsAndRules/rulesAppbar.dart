// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
class PatientRulesAppbar extends StatelessWidget {
  String? text;
   PatientRulesAppbar({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.kSecondryColor,
        title: Text( text!
          ,
          style: AppTextStyles.popins(
              style: const TextStyle(color: AppColors.kDarkColor, fontSize: 19)),
            
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back, color: AppColors.kPrimaryColor,) )
        
      );
  }
}