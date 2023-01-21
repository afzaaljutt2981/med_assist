import 'package:flutter/material.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../services/providers/RegisterUser.dart';
import '../../../services/widgets/PeramedicData/paramedic_incomes.dart';

class MyIncomeScreen extends StatefulWidget {
  const MyIncomeScreen({Key? key}) : super(key: key);

  @override
  State<MyIncomeScreen> createState() => _MyIncomeScreenState();
}

class _MyIncomeScreenState extends State<MyIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterPeramedic(),
      child: Consumer<RegisterPeramedic>(
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            child: (value.paramedicAllServiceList.isEmpty)
                ? Center(
                    child: Text(
                      "All your previous requests will be shown here within 24 hours",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 26)),
                    ),
                  )
                : ListView.builder(
                    itemCount: value.paramedicAllServiceList.length,
                    itemBuilder: (context, index) {
                      return ParamedicsIncomes(
                        getHistory: value.paramedicAllServiceList[index],
                      );
                    }),
          );
        },
      ),
    );
  }
}
