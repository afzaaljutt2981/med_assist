import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ParamedicDrawer.dart';
import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';
import '../supportScreen.dart';
import 'faqClasses/acceptRideScreen.dart';
import 'faqClasses/deleteProfile.dart';
import 'faqClasses/neddToKnowscreen.dart';
import 'faqClasses/pariorityWork.dart';

class ParamedicFaqClass extends StatefulWidget {
  const ParamedicFaqClass({Key? key}) : super(key: key);

  @override
  State<ParamedicFaqClass> createState() => _ParamedicFaqClassState();
}

class _ParamedicFaqClassState extends State<ParamedicFaqClass> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // Calling Drawe
      drawer: ParamedicDrawerWidget(),

      // AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            color: AppColors.kPrimaryColor,
          );
        }),
        backgroundColor: AppColors.kSecondryColor,
        title: Text(
          "FAQ",
          style: AppTextStyles.popins(
              style: const TextStyle(
                  color: AppColors.kDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ),

      // body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Help text
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
            child: Text(
              "Help",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
            ),
          ),

          //  Help Catagories
          Container(
            color: Colors.white,
            child: Column(
              children: [
                helpCatagories("How to accept a service request", onTap: () {
                  //  print("object");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ParamedicAcceptRequestScreen()));
                }),
                const Divider(
                  thickness: 1,
                ),
                helpCatagories("What you need to know", onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ParamedicNeedToKnowScreen()));
                }),
                const Divider(
                  thickness: 1,
                ),
                helpCatagories("How does priority work", onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PariorityWork()));
                }),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: helpCatagories("How to delete my profile", onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeleteProfile()));
                  }),
                ),
              ],
            ),
          ),

          // Feedback text
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
            child: Text(
              "Feedback",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
            ),
          ),

          //  FeedBack Catagories
          Container(
            color: Colors.white,
            child: Column(
              children: [
                feedbackCatagories("Technical Support chat", onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()));
                }, icon: Icons.chat),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: feedbackCatagories("Write to e-mail",
                      onTap: () {}, icon: Icons.email),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget helpCatagories(
    String text, {
    required Function() onTap,
  }) {
    return SizedBox(
      height: screenHeight * 0.051,
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: AppTextStyles.popins(
              style:
                  const TextStyle(color: AppColors.kDarkColor, fontSize: 14)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget feedbackCatagories(String text,
      {required Function() onTap, IconData? icon}) {
    return SizedBox(
      height: screenHeight * 0.051,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(
          text,
          style: AppTextStyles.popins(
              style:
                  const TextStyle(color: AppColors.kDarkColor, fontSize: 14)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
