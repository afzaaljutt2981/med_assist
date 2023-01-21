import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/ParamedicDrawer.dart';
import 'package:provider/provider.dart';

import '../../../services/providers/RegisterUser.dart';
import '../../../services/utils/app_text_style.dart';
import '../../../services/utils/colors.dart';
import '../../../services/widgets/PeramedicData/paramedic_history.dart';

class ParamedicHistory extends StatefulWidget {
  const ParamedicHistory({Key? key}) : super(key: key);

  @override
  State<ParamedicHistory> createState() => _ParamedicHistoryState();
}

class _ParamedicHistoryState extends State<ParamedicHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Calling Drawe
      drawer: ParamedicDrawerWidget(),

      // AppBar
      appBar: AppBar(
        leading: Builder(
            builder: (context) {
              return IconButton(onPressed: (){
                Scaffold.of(context).openDrawer();
              }, icon: const Icon(Icons.menu),color: AppColors.kPrimaryColor, );
            }
        ),
        backgroundColor: AppColors.kSecondryColor,
        title: Text("My History", style: AppTextStyles.popins(
            style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 16,
                fontWeight: FontWeight.w600
            )

        ),),
      ),
      body: ChangeNotifierProvider(
        create: (context)=>RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
          builder: (BuildContext context, value, Widget? child) {
            return Container(
              child: ListView.builder(
                  itemCount:value.paramedicAllServiceList.length,
                  itemBuilder: (context, index) {
                    return RequestHistoryParamedic( getHistory: value.paramedicAllServiceList[index],);
                  }),
            );
            },
        ),
      ),
    );
  }
}
