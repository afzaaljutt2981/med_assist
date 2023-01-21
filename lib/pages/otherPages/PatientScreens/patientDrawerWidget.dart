import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/homeScreen.dart';
import 'package:med_assist/pages/otherPages/editProfile.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/faqClass.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/requestHistoryScreen.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/safetyScreen.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/settingsScreen.dart';
import 'package:med_assist/pages/otherPages/supportScreen.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../services/providers/RegisterUser.dart';
import '../../../services/utils/app_text_style.dart';

class PatientDrawer extends StatefulWidget {
  const PatientDrawer({Key? key}) : super(key: key);

  @override
  State<PatientDrawer> createState() => _PatientDrawerState();
}

// User Details Drawer
class _PatientDrawerState extends State<PatientDrawer> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterPeramedic>(
      create: (context) => RegisterPeramedic(),
      child: Consumer<RegisterPeramedic>(builder: (context, value, child) {
        // value.getCurrentUserData();
        return Drawer(
          backgroundColor: AppColors.kSecondryColor,
          child: Container(
            color: AppColors.kSecondryColor,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // Drawer Header
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => EditProfile(
                                  firstname: value.user!.fName,
                                  lastname: value.user!.lName,
                                  email: value.user!.email!,
                                )));
                  },
                  child: SizedBox(
                      height: 120,
                      child: DrawerHeader(
                        child: ListView.builder(
                          itemCount: 1, //userProfile.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 12),
                              child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (value.user != null)
                                        ? (value.user!.image == "")
                                            ? const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    "assets/images/extra/profilePic.png"))
                                            : CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    value.user!.image!))
                                        : Container(
                                            color: Colors.white,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      width: screenWidth * 0.035,
                                    ),
                                    Text(
                                      (value.user == null)
                                          ? " "
                                          : value.user!.fName,
                                      style: AppTextStyles.popins(
                                          style: const TextStyle(
                                              color: AppColors.kDarkColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Text(
                                      (value.user == null)
                                          ? " "
                                          : value.user!.lName,
                                      style: AppTextStyles.popins(
                                          style: const TextStyle(
                                              color: AppColors.kDarkColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                    ),
                                    SizedBox(width: screenWidth * 0.04),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: const Icon(
                                          Icons.navigate_next,
                                          color: AppColors.kPrimaryColor,
                                          size: 40,
                                        ),
                                      ),
                                    )
                                  ]),
                            );
                          },
                        ),
                      )),
                ),

                drawerFunctionalties(
                    "City", "assets/images/homeScreen/Drawer/city.png",
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }),
                drawerFunctionalties("Request history",
                    "assets/images/homeScreen/Drawer/history.png", onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHistory()));
                }),
                drawerFunctionalties(
                    "Safety", "assets/images/homeScreen/Drawer/safety.png",
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SafetyScreen()));
                }),
                drawerFunctionalties(
                    "Settings", "assets/images/homeScreen/Drawer/settings.png",
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PatientsSettingsScreen()));
                }),
                drawerFunctionalties(
                    "FAQ", "assets/images/homeScreen/Drawer/faq.png",
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientFaqClass()));
                }),
                drawerFunctionalties(
                    "Support", "assets/images/homeScreen/Drawer/support.png",
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()));
                }),

                SizedBox(
                  height: screenHeight * 0.2,
                ),

                const Divider(
                  thickness: 1,
                ),

                SizedBox(
                  height: screenHeight * 0.045,
                ),

                // Peramedic mode button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParamedicHomeScreen()));
                        },
                        child: Text(
                          "Peramedic mode ",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )),
                ),

                // Row of SOcial media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: screenWidth * 0.09,
                        height: screenHeight * 0.07,
                        child: InkWell(
                            onTap: () {},
                            child: const Image(
                                image: AssetImage(
                                    "assets/images/homeScreen/facebook.png")))),
                    SizedBox(
                      width: screenWidth * 0.04,
                    ),
                    SizedBox(
                        width: screenWidth * 0.09,
                        height: screenHeight * 0.07,
                        child: InkWell(
                            onTap: () {},
                            child: const Image(
                                image: AssetImage(
                                    "assets/images/homeScreen/instagram.png"))))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget drawerFunctionalties(String text, String image, {required Function onTap}) {
    return Material(
      color: AppColors.kSecondryColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.grey.shade300,
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 25),
          child: Container(
            child: Row(
              children: [
                SizedBox(
                    width: 27,
                    height: 27,
                    child: Image(image: AssetImage(image))),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.kDarkColor)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
