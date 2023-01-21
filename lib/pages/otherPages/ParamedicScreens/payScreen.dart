import 'package:flutter/material.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';

class MyPaymentsScreen extends StatefulWidget {
  const MyPaymentsScreen({Key? key}) : super(key: key);

  @override
  State<MyPaymentsScreen> createState() => _MyPaymentsScreenState();
}

class _MyPaymentsScreenState extends State<MyPaymentsScreen> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),

          //Personal account text
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              "Personal account: 12343",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
            ),
          ),

          //Balance
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 5),
            child: Text(
              "Balance: PKR 0.00",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 14,
                // fontWeight: FontWeight.w600
              )),
            ),
          ),

          //Refund amount
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 5),
            child: Row(
              children: [
                Text(
                  "Refund: PKR 0.00",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 14,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "(What is it?)",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),

          //Payments method
          paymentMethods(
              AppColors.kPrimaryColor, AppColors.kWhiteColor, "Online check",
              onTap: () {}),
          paymentMethods(
              Colors.yellow.shade600, AppColors.kDarkColor, "Top up account",
              onTap: () {}),
          paymentMethods(Colors.yellow.shade600, AppColors.kDarkColor,
              "Balance statistics",
              onTap: () {}),
          paymentMethods(
              AppColors.kWhiteColor, AppColors.kDarkColor, "Payments",
              onTap: () {})
        ],
      ),
    );
  }

  Widget paymentMethods(Color color, Color textColor, String text, {required Function() onTap,}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.12),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: screenWidth * 0.92,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Text(
                  text,
                  style: AppTextStyles.popins(
                      style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
