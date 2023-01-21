import 'package:flutter/material.dart';

import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
import '../../supportScreen.dart';
import '../ParamedicDrawer.dart';

class PariorityWork extends StatelessWidget {
  const PariorityWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // Calling Drawe
      drawer:  ParamedicDrawerWidget(),

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

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.kPrimaryColor,
                      ),
                      Text(
                        "Back",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Main Heading
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: Text(
                "How does Priority work",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.kDarkColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),

            // Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                """
What determines your Priority
Your priority depends on the ratings that patients leave at the end of the servce you provided. Priority is also affected by the number of orders completed, your ratings, and any complaints from patients. To boost your priority, complete more orders and get more good ratings.

How to remove a negative rating or review
You can't delete a rating or review in the app, but good ratings and reviews from other patients will guarantee you high Priority.

Who gave me a low rating or a bad review using the handle 'Patient'?
The handle 'Patient' refers to someone you transported and had a conflict with. We conceal their real name for safety reasons.

What to do if there is a conflict with a patient
Go to 'Support' and write to us that what happened.""",
                style: AppTextStyles.popins(
                    // ignore: prefer_const_constructors
                    style:
                        const TextStyle(fontSize: 15, color: AppColors.kDarkColor)),
              ),
            ),

            // Support Box
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()));
                },
                child: Container(
                  height: screenHeight * 0.08,
                  width: screenWidth * 0.85,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: screenHeight * 0.09,
                          width: screenWidth * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kPrimaryColor,
                          ),
                          child: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Write to support",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kPrimaryColor)),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}