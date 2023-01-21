import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../services/widgets/patient/request_history_widget.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Calling Drawer
      drawer: const PatientDrawer(),

      // AppBar
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            color: AppColors.kPrimaryColor,
          );
        }),
        backgroundColor: Colors.white,
        title: Text(
          "Request History",
          style: AppTextStyles.popins(
              style: const TextStyle(
                  color: AppColors.kDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context)=>RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
          builder: (BuildContext context, value, Widget? child) {
            return Container(
              child: ListView.builder(
                  itemCount:value.getPatientHistory.length,
                  itemBuilder: (context, index) {
                    return RequestHistoryPatient( getHistory: value.getPatientHistory[index],);
                  }),
            );
          },
        ),
      ),
    );
  }
}
