import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/services/utils/app_text_style.dart';

import '../../models/PatientModels/senRequestModel.dart';

class RequestHistoryPatient extends StatefulWidget {
  RequestHistoryPatient({Key? key,required this.getHistory}) : super(key: key);
ServiceModel getHistory;
  @override
  State<RequestHistoryPatient> createState() => _RequestHistoryPatientState();
}

class _RequestHistoryPatientState extends State<RequestHistoryPatient> {

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
          Text("${widget.getHistory.serviceName} Service", style: AppTextStyles.popins(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
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
              // const Text(
              //   "Completed",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // )
            ],
          ),
          SizedBox(height: 7,),
          Divider(),
        ],
      ),
    );
  }
}
