import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:med_assist/services/models/PatientModels/homeScreenModels/drowerProfileModel.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/PatientModels/getParamedicOffers.dart';

class OffersWidget extends StatefulWidget {
  OffersWidget(
      {Key? key,
      required this.model,
      required this.user,
      required this.onPressed,
      required this.onPress})
      : super(key: key);
  GetParamedicsOffers model;
  void Function() onPressed;
  void Function() onPress;
  DrawerProfileModel user;
  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 15)).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.user.id)
            .collection("paramedicRequests")
            .doc(widget.model.id)
            .delete();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 10)
          ],
          color: Colors.white,
        ),
        width: screenWidth * 0.9,
        height: screenHeight * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [

              Padding(
                padding: const EdgeInsets.only(top: 15, left: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.model.image),
                ),
              ), //
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "${widget.model.serviceName} Service",
                              style: AppTextStyles.popins(
                                  style: const TextStyle(
                                      color: AppColors.kDarkColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Text(
                            "PKR ${widget.model.price}",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.model.paramedicName,
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontSize: 14,
                            )),
                          ),
                          Text(
                            "0.0km", // ${widget.model.latitude.toStringAsFixed(1)}
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                              color: AppColors.kDarkColor,
                              fontSize: 14,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kWhiteColor,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade100),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        widget.onPress;
                      },
                      child: Text(
                        "Decline",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        )),
                      ),
                    )),
                Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kPrimaryColor,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: widget.onPressed,
                      child: Text(
                        "Accept",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 16,
                        )),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
