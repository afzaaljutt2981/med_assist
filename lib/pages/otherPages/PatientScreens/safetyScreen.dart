import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';
import '../../../services/utils/colors.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({Key? key}) : super(key: key);

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}


class _SafetyScreenState extends State<SafetyScreen> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
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
        title: Text("Safety", style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kDarkColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
          )

        ),),
      ),
     
      // body
       
           body: Container(
            margin: const EdgeInsets.all(15),
            child: SingleChildScrollView (
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                 
                 // Who do you want to contact? text
                 SizedBox( height: screenHeight * 0.045, ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 7, right: 7, bottom: 3),
                    child: Text("Who do you want to contact?", textAlign: TextAlign.center , style: AppTextStyles.popins(
                      style: const TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 27,
                        fontWeight: FontWeight.w700
                      )
                    ), ),
                  ),
                 
                  // help text
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 7, right: 7),
                    child: Text("You can contact on the emergency number to get help.", textAlign: TextAlign.center , style: AppTextStyles.popins(
                      style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400
                      )
                    ), ),
                  ),
                  
                  // Safety Picture
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 55),
                    child: Image(image: AssetImage("assets/images/extra/safetyScreen/safety.png")),
                  ),
               
                  // Help Button(Police)
                    SizedBox( height: screenHeight * 0.12, ),
                  Center(
                    child: Container(
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
                                      borderRadius: BorderRadius.circular(20)))),
                          onPressed: () {
                            setState(() {

                              final Uri uri = Uri(
                                  scheme: 'tel',
                                  path: '112'
                              );
                              _launchUrl(uri);
                            });
                          },
                          child: Text(
                            "Police",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        )),
                  ),
            
                  // Help Button(Ambulance)
                   SizedBox( height: screenHeight * 0.03, ),
                  Center(
                    child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                         // color: AppColors.kWhiteColor,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.kWhiteColor
                            ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                          onPressed: () {
                            setState(() {
                              final Uri uri = Uri(
                                  scheme: 'tel',
                                  path: '115'
                              );
                              _launchUrl(uri);
                            });
                          },
                          child: Text(
                            "Ambulance",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                   color: AppColors.kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        )),
                  ),
                ],
              ),
            ),
           ),
    

    );
  }

  Future<void> _launchUrl (Uri uri) async {
    try {
      if (await canLaunchUrl(uri )) {
        await launchUrl(uri);
      }
      else {
        throw 'Could not launch $uri';
      }
    } catch (_){}
  }

}