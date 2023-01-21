import 'package:flutter/material.dart';

import '../../../pages/otherPages/ParamedicScreens/homeScreen.dart';
import '../../utils/app_text_style.dart';
import '../../utils/colors.dart';

// ignore: must_be_immutable
class ParamedicRegisterAppbar extends StatelessWidget {
  String? screenName;
  ParamedicRegisterAppbar({Key? key,  this.screenName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kSecondryColor,
       
       // BAck text
        leading: TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Back", style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kPrimaryColor,
            fontSize: 16,
          )
        ),)),
        
        //center title
        title: Text(screenName! , style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kDarkColor,
            fontSize: 20,
          )
        ), ),
         
         // Close Button
        actions: [
          TextButton(onPressed: (){
              _showDialogueBoxClose(context);
          }, child: Text("Close" , style: AppTextStyles.popins(
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          )
        ),) )
        ],
       );
  }
   //CLose Button Dialogue
  Future<void> _showDialogueBoxClose(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "Are you sure you want to close this window?",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 14)),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                     
                       Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ParamedicHomeScreen() ), (route) => false);
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
              ],
            ),
          );
        });
  }
}