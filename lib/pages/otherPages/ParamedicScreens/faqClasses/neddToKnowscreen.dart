import 'package:flutter/material.dart';

import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
import '../../supportScreen.dart';
import '../ParamedicDrawer.dart';

class ParamedicNeedToKnowScreen extends StatelessWidget {
  const ParamedicNeedToKnowScreen({Key? key}) : super(key: key);

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
                "What you need to know",
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
How to accept a service request
Open your service request feed. To accept a service request, tap it and select your arrival time. If you aren't happy with the current price, offer your own and wait for the patient to respond.

How to get the order
If you have a low rating, or you proposed a price that is too high, other paramedics will take the service offer. Conflict-free paramedics and a good communication can help you earn a higher rating.

What to do if the patient starts a conflict
Before marking the service request as completed, tap 'Problems with patient' and select the appropriate option. We block violators' profiles, to help prevent similar situations in the future.

How to call a patient from within the app
If the call does not go through, try deleting the app and downloading it again. Open the app, and when you see the first notification tap 'Allow' and select 'Phone'. Your phone settings will open: give the app the access to calls.

How to remove ride requests from a different city
In the side menu tap your profile, change the city you need and save it. Then select your own city and restart the app.

What to do if the in-app GPS isn't working
If your phone has two SIM cards, insert the SIM with the number you used to register for the app into slot 1. Then select High accuracy' in the GPS settings.
If you have an iPhone, give the inDriver app access to location data in your privacy settings or reinstall the app. If you have Android, switch off the power-saving mode. Then switch the GPS off and then on again in your phone settings.

What to do if the app keeps asking you to enter your phone number
If your phone has two SIM cards, insert the SIM with the number you used to register for the app into slot 1.

What determines a patient's rating
A low rating for a patient means they often cancel their orders and receive complaints from paramedics. The rating can also rise or fall depending on the ratings they receive from paramedics.""",
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