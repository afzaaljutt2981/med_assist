import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ParamedicDrawer.dart';
import 'package:provider/provider.dart';
import '../../../services/providers/RegisterUser.dart';
import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';
import '../PatientScreens/editNumberScreen.dart';
import '../splashScreen.dart';
import 'RulesAndTerms/RulesAndTermsScreen.dart';

class ParamedicSettingsScreen extends StatefulWidget {
  const ParamedicSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ParamedicSettingsScreen> createState() =>
      _ParamedicSettingsScreenState();
}

class _ParamedicSettingsScreenState extends State<ParamedicSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            "Settings",
            style: AppTextStyles.popins(
                style: const TextStyle(
                    color: AppColors.kDarkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
        ),

        // body
        body: ChangeNotifierProvider<RegisterPeramedic>(
          create: (context) => RegisterPeramedic(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<RegisterPeramedic>(builder: (context, value, child) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPatientNumber())),
                  title: Text(
                    "Phone number",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                      color: AppColors.kDarkColor,
                    )),
                  ),
                  subtitle: Text((value.user!.phoneNumber == "")
                      ? ""
                      : value.user!.phoneNumber),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              }),
              // User number and Language Builder

              ListTile(
                title: Text(
                  "Language ",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                    color: AppColors.kDarkColor,
                  )),
                ),
                subtitle: Text("Default language"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RulesAndTerms())),
                title: Text(
                  "Rules and terms",
                  style: AppTextStyles.popins(
                      style: const TextStyle(
                    color: AppColors.kDarkColor,
                  )),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              // logout Button
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: TextButton(
                    onPressed: () {
                      _showDialogueBox(context);
                    },
                    child: Text(
                      "Log out",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kPrimaryColor, fontSize: 16)),
                    )),
              )
            ],
          ),
        ));
  }

// Alert Dialogue Box
  Future<void> _showDialogueBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "Do you want to log out?",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 16)),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
                TextButton(
                    onPressed: () {
                      final auth = FirebaseAuth.instance;
                      auth.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (c) => MySplashscreen()),
                            (route) => false);
                      });
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
              ],
            ),
          );
        });
  }
}
