import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ParamedicDrawer.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/myIncomeScreen.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/payScreen.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ratingScreen.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/registerScreen.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/requestsScreen.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../services/utils/app_text_style.dart';
import '../splashScreen.dart';

class ParamedicHomeScreen extends StatefulWidget {
  const ParamedicHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ParamedicHomeScreen> createState() => _ParamedicHomeScreenState();
}

int selectedIndex = 0;
int indexOfToggle = 0;

class _ParamedicHomeScreenState extends State<ParamedicHomeScreen> {
  List<Widget> widgets = [
    const PatientsRequestsScreen(),
    const MyIncomeScreen(),
    const MyRatingScreen(),
    const MyPaymentsScreen()
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool isToggled = true;
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<RegisterPeramedic> (
      create: (context) => RegisterPeramedic(),
      child: Consumer<RegisterPeramedic>(
        builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.kSecondryColor,
          // Calling Drawe
          drawer: const ParamedicDrawerWidget(),
      
          // AppBar
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60), child: appBarWidget(value)),
      
          body: widgets[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Requests",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payments), label: "My incoms"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_border_rounded), label: "Rating"),
              BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Pay"),
            ],
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.kDarkColor,
            currentIndex: selectedIndex,
            onTap: onTapped,
          ),
        );
      }),
    );
  }

  // Alert Dialogue Box
  Future<void> _showDialogueBoxProcced(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "To start earning wit MED Assist you need to fill in your personal information",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 14)),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  const ParamedicRegistrationScreen()));
                    },
                    child: const Text(
                      "Procced",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
              ],
            ),
          );
        });
  }

Future<void> _showDialogueBoxRegistered(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "You are already registerd as a paramedic, Try to mantain good ratings for more orders",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 14)),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 16),
                    )),
              ],
            ),
          );
        });
  }

  Widget appBarWidget(value) {
    return AppBar(
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

      //Toggle Switch
      title: ToggleSwitch(
        minWidth: 100.0,
        
        initialLabelIndex:  (value.count == 4)? 1 : 0,
        cornerRadius: 20.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        totalSwitches: 2,
        labels: const ['Offline', 'Online'],
        icons: const [Icons.wifi_off_rounded, Icons.wifi_rounded],
        activeBgColors: const [
          [Colors.pink],
          [Colors.pink]
        ],
        onToggle: (index) async {
          if (index == 1) {
            (value.count == 4)?
            await _showDialogueBoxRegistered(context)
            :
            await _showDialogueBoxProcced(context);
            setState(() {
              index = index! - 1;
            });
          }
        },
      ),

      // Settings button
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_suggest_sharp),
          color: AppColors.kPrimaryColor,
        )
      ],
    );
  }
}
