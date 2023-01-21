import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/authScreens/phoneVerification.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/editNumberScreen.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/termsAndRules/rulesAndTermsScreen.dart';
import 'package:med_assist/pages/otherPages/splashScreen.dart';
import 'package:provider/provider.dart';

import '../../../services/providers/RegisterUser.dart';
import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';
class PatientsSettingsScreen extends StatefulWidget {
  const PatientsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsSettingsScreen> createState() => _PatientsSettingsScreenState();
}


class _PatientsSettingsScreenState extends State<PatientsSettingsScreen> {

 // Patient Settings Model
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,

       // Calling Drawe
      drawer: const PatientDrawer(),

      // AppBar
         appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
               Scaffold.of(context).openDrawer();
            }, icon: const Icon(Icons.menu),color: AppColors.kPrimaryColor, );
          }
        ),
        backgroundColor: AppColors.kSecondryColor,
        title: Text("Settings", style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kDarkColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
          )

        ),),
      ),
      body: ChangeNotifierProvider<RegisterPeramedic>(
        create: (context) => RegisterPeramedic(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<RegisterPeramedic> (
                builder: (context, value, child){
                  return    ListTile(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditPatientNumber() )),
                    title: Text(
                      "Phone number", style: AppTextStyles.popins(
                        style: const TextStyle(
                          color: AppColors.kDarkColor,
                        )),),
                    subtitle: Text(
                        (value.user!.phoneNumber == "" )? "":
                        value.user!.phoneNumber  ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  );}
            ),
            // User number and Language Builder

            ListTile(
              title: Text("Language ", style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                  )),),
              subtitle: Text("Default language" ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const PatientRulesAndTerms() )),
              title: Text("Rules and terms" , style: AppTextStyles.popins(
                  style: const TextStyle(
                    color: AppColors.kDarkColor,
                  )),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            // logout Button
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: TextButton(
                  onPressed: () {
                    _showDialogueBox(context);
                  },
                  child: Text(
                    "Log out",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kPrimaryColor, fontSize: 16)),
                  )),
            )
          ],
        ),
      ),
       // body
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //
      //     // User number and Language Builder
      //     SizedBox(
      //       height: screenHeight *0.26,
      //       child: ListView.builder(
      //         physics: const BouncingScrollPhysics(),
      //  itemCount: patientSettingsList.length,
      //  itemBuilder: (context, index) {
      //   var model = patientSettingsList[index];
      //
      //   return ListTile(
      //   onTap: (){
      //     if (model.widget != null) {
      //                     Navigator.of(context)
      //                         .push(MaterialPageRoute(builder: (context) {
      //                       return model.widget!;
      //                     }));
      //                   }
      //   },
      //    title: Text(model.title1 ,style: AppTextStyles.popins(
      //        style: const TextStyle(
      //          color: AppColors.kDarkColor,
      //
      //        )
      //    ), ),
      //
      //    subtitle: Text(model.title2!,  ),
      //
      //    trailing: const Icon(Icons.arrow_forward_ios),
      //  );
      // },),
      //     ),
      //
      //     // logout Button
      //      Padding(
      //        padding: const EdgeInsets.only(left: 9),
      //        child: TextButton(onPressed: (){
      //            _showDialogueBox(context);
      //        }, child: Text("Log out",style: AppTextStyles.popins(
      //         style: const TextStyle(
      //           color: AppColors.kPrimaryColor,
      //           fontSize: 16
      //         )
      //        ), )),
      //      )
      //     ],
      // )


    );
  }}



  // Alert Dialogue Box
  Future<void> _showDialogueBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text("Do you want to log out?", style: AppTextStyles.popins(
               style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 16
               )
            ),),
            
            actions: [
              TextButton(
                  onPressed: () {
                     Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                   final auth = FirebaseAuth.instance;
                  auth.signOut().then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>  MySplashscreen() ), (route) => false);
                  } );
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                  )),
            ],
          ),
        );
      });
}