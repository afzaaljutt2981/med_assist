import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:med_assist/services/utils/colors.dart';

class LoadingDialogue{
  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      decoration:
      const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpinKitCircle(
              duration: Duration(seconds: 2),
              size: 60,
              color: AppColors.kPrimaryColor
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              "$text...",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}