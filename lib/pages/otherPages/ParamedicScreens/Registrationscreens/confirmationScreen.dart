import 'package:flutter/material.dart';
import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
import '../../../../services/widgets/loadingDialogue.dart';
import '../ParamedicDrawer.dart';
import '../homeScreen.dart';

class RegistrationConfirmationScreen extends StatefulWidget {
  const RegistrationConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationConfirmationScreen> createState() =>
      _RegistrationConfirmationScreenState();
}

class _RegistrationConfirmationScreenState
    extends State<RegistrationConfirmationScreen> {
  get screenWidth => MediaQuery.of(context).size.width;
  get screenHeight => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        // Calling Drawer
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
            "Online registration",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        body: Column(
          children: [
            confirmationBox(),
            const SizedBox(
              height: 20,
            ),
            doneButton(),
          ],
        ));
  }

  Widget confirmationBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.kPrimaryColor),
              child: const Icon(
                Icons.done,
                color: AppColors.kWhiteColor,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              "Application sent",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                "Verification process will take 4 hours. If we didn't manage to check your documents in 4 hours, please inform us in the chat",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                  fontWeight: FontWeight.w500,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doneButton() {
    return Container(
        height: screenHeight * 0.07,
        width: screenWidth * 0.87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.kPrimaryColor,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)))),
          onPressed: () async {
            LoadingDialogue.showLoaderDialog(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => ParamedicHomeScreen()));
          },
          child: Text(
            "Done ",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ));
  }
}
