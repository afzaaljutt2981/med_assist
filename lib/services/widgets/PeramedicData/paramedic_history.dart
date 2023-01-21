import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/services/utils/app_text_style.dart';

import '../../models/PatientModels/senRequestModel.dart';
import '../../models/PeramedicModels/servicesListModel.dart';

class RequestHistoryParamedic extends StatefulWidget {
  RequestHistoryParamedic({Key? key,required this.getHistory}) : super(key: key);
  ParamedicServiceList getHistory;
  @override
  State<RequestHistoryParamedic> createState() => _RequestHistoryParamedic();
}

class _RequestHistoryParamedic extends State<RequestHistoryParamedic> {

  @override
  void initState() {
    formatRequestDate();
    super.initState();
  }
  formatRequestDate(){
    time = DateTime.fromMillisecondsSinceEpoch(widget.getHistory.time);
    requestMonth = DateFormat("MMMM").format(time!);
    requestDay = time!.day;
    currentDay = DateTime.now().day;
    formattedTime = DateFormat.jm().format(time!);
  }
  DateTime? time;
  var requestMonth;
  var requestDay;
  var currentDay;
  String formattedTime = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text("${widget.getHistory.serviceName} Service", style: AppTextStyles.popins(
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              )
          ), ),
          Text(widget.getHistory.patientName, style: AppTextStyles.popins(
              style: const TextStyle(
                  fontSize: 14,
              )
          ), ),
          Text(
            (requestDay==currentDay)?formattedTime:
            "$requestDay $requestMonth", style: AppTextStyles.popins(
              style: const TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold
              )
          ), ),
          Text(widget.getHistory.address),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PKR ${widget.getHistory.price}"),
              const Text(
                "Completed",
                style: TextStyle(fontSize: 14,),
              )
            ],
          ),
          SizedBox(height: 7,),
          Divider(),
        ],
      ),
    );
  }
}
