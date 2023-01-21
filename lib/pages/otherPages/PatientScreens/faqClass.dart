import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientFaqScreens/complainAParamedic.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientFaqScreens/patientLeaveReviewForParamedic.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientFaqScreens/peramedicNotResponse.dart';
import 'package:med_assist/pages/otherPages/supportScreen.dart';

import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';

class PatientFaqClass extends StatefulWidget {
  const PatientFaqClass({Key? key}) : super(key: key);

  @override
  State<PatientFaqClass> createState() => _PatientFaqClassState();
}


class _PatientFaqClassState extends State<PatientFaqClass> {

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
        title: Text("FAQ", style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kDarkColor,
            fontSize: 18,
            fontWeight: FontWeight.w600
          )

        ),),
      ),
      
      // body
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
           // Help text
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
              child: Text("Help",style: AppTextStyles.popins(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                )
              ), ),
            ),
            
            //  Help Catagories
            Container(
             
              color: Colors.white,
              height:screenHeight*0.23 ,
              child: Column(
                children: [
                   helpCatagories("Peramedics do not respond" , onTap: (){
                    //  print("object");
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const PeramedicNotResponseClass() ));
                   }),
                  const Divider( thickness: 1, ),
                  helpCatagories("How to leave a review for a paramedic", onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const LeaveAReviweForPreamedic() ));
                  }),
                  const Divider( thickness: 1, ),
                  helpCatagories("How to complain", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ComplainAParamedic() ));
                  }), 
                ],
              ),
            ),
         
           // Feedback text
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
              child: Text("Feedback",style: AppTextStyles.popins(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                )
              ), ),
            ),

            //  FeedBack Catagories
            Container(
             
              color: Colors.white,
              height:screenHeight*0.145 ,
              child: Column(
                children: [
                  feedbackCatagories("Technical Support chat", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SupportScreen()));
                  },
                  icon: Icons.chat
                  ),
                   const Divider( thickness: 1, ),
                    feedbackCatagories("Write to e-mail", onTap: (){},
                  icon: Icons.email
                  ),
                ],
              ),
            ),
          
          
          ],
        ),
    );
  }
  // help catagories
  Widget helpCatagories( String text,{required Function() onTap, } ){
    return  SizedBox(
                    height: screenHeight*0.061,
                    child: ListTile(
                     onTap: onTap,
                      title: Text( text , style: AppTextStyles.popins(
                        style: const TextStyle(
                          color: AppColors.kDarkColor,
                          fontSize: 14
                        )
                      ),),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
  }
   
  // feedback catagories
  Widget feedbackCatagories( String text,{required Function() onTap,  IconData? icon } ){
    return  SizedBox(
                    height: screenHeight*0.059,
                    child: ListTile(
                      onTap: onTap,
                      leading: Icon(icon),
                      title: Text( text , style: AppTextStyles.popins(
                        style: const TextStyle(
                          color: AppColors.kDarkColor,
                          fontSize: 14
                        )
                      ),),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
  }
}