import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ParamedicDrawer.dart';
import 'package:med_assist/pages/otherPages/supportScreen.dart';
import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';

class ParamedicAcceptRequestScreen extends StatefulWidget {
  const ParamedicAcceptRequestScreen({Key? key}) : super(key: key);

  @override
  State<ParamedicAcceptRequestScreen> createState() =>
      _ParamedicAcceptRequestScreenState();
}

class _ParamedicAcceptRequestScreenState
    extends State<ParamedicAcceptRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                "How to accept a service request",
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
                """1. Open the request feed.

2. Select a service request that suits you. Each contains both addresses and the price, and displays the patient's rating and photo.

3. If the price for the service does not suit you, offer your own.

4. If the patient accepts the offer, make sure you're familiar with the route.

5. When you arrive at the patient's location, don't forget to tap 'I'm here'.

6. If there is no one at the pinned location, call the patient.

7. Try not to cancel accepted orders and increase your Priority.

You will receive push notifications of service requests near you. Skip them if the conditions do not suit you.

We are always here for you in Support. Have the nice services only!""",
                style: AppTextStyles.popins(
                    // ignore: prefer_const_constructors
                    style:
                        TextStyle(fontSize: 15, color: AppColors.kDarkColor)),
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
