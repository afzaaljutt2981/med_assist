import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MyRatingScreen extends StatefulWidget {
  const MyRatingScreen({Key? key}) : super(key: key);

  @override
  State<MyRatingScreen> createState() => _MyRatingScreenState();
}

class _MyRatingScreenState extends State<MyRatingScreen> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterPeramedic>(
      create: (context) => RegisterPeramedic(),
      child: Consumer<RegisterPeramedic>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ratingContainer(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              countingReviewsAndServices(value),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Center(
                  child:
                  (value.paramedicAllServiceList.isEmpty)
                      ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                            "At the moment you didn't receive any reviews",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontSize: 20,
                            )),
                          ),
                      )
                      : userRatingsContainer(value))
            ],
          ),
        ),
      ),
    );
  }
    // user Real time Rating
  Widget userRatingsContainer(value) {
    return Container(
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "Your Ratings",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: screenHeight * 0.09,
          ),
          (value.user != null)
              ? (value.user!.image == "")
                  ? const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/images/extra/profilePic.png"))
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      backgroundImage: NetworkImage(value.user!.image!))
              : Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (value.user == null) ? " " : value.user!.fName,
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
              Text(
                (value.user == null) ? " " : value.user!.lName,
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
              ),
            ],
          ),
          Text(
            "Maintain good reviews to get more orders",
            style: AppTextStyles.popins(
                style:
                    const TextStyle(color: AppColors.kDarkColor, fontSize: 12)),
          ),
          SizedBox(
            height: screenHeight * 0.013,
          ),
          RatingStars(
            value: (value.overAllReviews == null) ? 0 : value.overAllReviews!,
            starBuilder: (index, color) {
              return Icon(
                Icons.star_sharp,
                color: color,
                size: 30,
              );
            },
            starCount: 5,
            starSize: 30,
            maxValue: 5,
            starSpacing: 2,
            maxValueVisibility: true,
            valueLabelVisibility: false,
            animationDuration: Duration(milliseconds: 1000),
            starOffColor: Color(0xffe7e8ea),
            starColor: Colors.yellow,
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          (value.overAllReviews == null)
              ? const Text("")
              : Text("(${value.overAllReviews!.toStringAsFixed(1)}/5)"),
          SizedBox(
            height: screenHeight * 0.015,
          )
        ],
      ),
    );
  }

  // Rating Container
  Widget ratingContainer() {
    return Center(
      child: Container(
        width: screenWidth * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rating",
                  style: AppTextStyles.popins(
                      style: const TextStyle(color: AppColors.kDarkColor)),
                ),
                const Icon(
                  Icons.question_mark_sharp,
                  size: 23,
                  color: AppColors.kPrimaryColor,
                )
              ],
            ),
            Text(
              "Normal    ",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor,
                      fontSize: 21,
                      fontWeight: FontWeight.w600)),
            ),
            linearPercentIndicator("Reviews: medium", 0.6, AppColors.kDarkColor,
                AppColors.kPrimaryColor),
            linearPercentIndicator("Ecperiance: novice", 0.2,
                AppColors.kDarkColor, Color.fromARGB(255, 253, 25, 9)),
            linearPercentIndicator(
                "Reputation: excellent", 1, AppColors.kDarkColor, Colors.green),
            linearPercentIndicator("Frequency of operation: very low", 0.2,
                AppColors.kDarkColor, Color.fromARGB(255, 250, 22, 5)),
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  // Counting Ratings and serivices Container
  Widget countingReviewsAndServices(value) {
    return Center(
      child: Container(
        width: screenWidth * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: (value.paramedicServicesCounter == null)
                          ? Text(
                              "0",
                              style: AppTextStyles.popins(
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 18)),
                            )
                          : Text(
                              value.paramedicServicesCounter.toString(),
                              style: AppTextStyles.popins(
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 18)),
                            )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      "Services",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kDarkColor, fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: (value.paramedicTotalReviewsCounter == null)
                          ? Text(
                              "0",
                              style: AppTextStyles.popins(
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 18)),
                            )
                          : Text(
                              value.paramedicTotalReviewsCounter.toString(),
                              style: AppTextStyles.popins(
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 18)),
                            )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      "reviews",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kDarkColor, fontSize: 11)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Prercent Indicator bar
  Widget linearPercentIndicator(String text, double percent, Color textColor, Color progressColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: LinearPercentIndicator(
          animation: true,
          animationDuration: 1200,
          barRadius: const Radius.circular(10),
          center: Padding(
            padding: const EdgeInsets.only(left: 25, right: 9),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 10, fontWeight: FontWeight.w500, color: textColor),
            ),
          ),
          width: screenWidth * 0.9,
          percent: percent,
          lineHeight: 15,
          progressColor: progressColor,
          backgroundColor: AppColors.kWhiteColor,
        ),
      ),
    );
  }
}
