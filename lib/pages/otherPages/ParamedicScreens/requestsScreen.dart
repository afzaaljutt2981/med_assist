import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/requestDetailsScreen.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';

class PatientsRequestsScreen extends StatefulWidget {
  const PatientsRequestsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsRequestsScreen> createState() => _PatientsRequestsScreenState();
}

bool isToggled = true;

class _PatientsRequestsScreenState extends State<PatientsRequestsScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    setPosition();
    print(position?.longitude);
  }
  // Patient requests list

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<RegisterPeramedic>(
      create: (context) => RegisterPeramedic(),
      child: Consumer<RegisterPeramedic>(builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.serviceRequest.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            var model = value.serviceRequest[i];
            var date = DateTime.fromMillisecondsSinceEpoch(model.time);
            String formattedTime = DateFormat.jm().format(date); //
            // var model = patientsRequestList[index];
            return Container(
               height: screenHeight * 0.12,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade400))),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcceptPatientRequest(
                                        currentService: value.serviceRequest[
                                            i], //currentParamedic: value.user! ,
                                      )));
                        },
                        child: SizedBox(
                          width: screenWidth * 0.935,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 10),
                                    child:
                                    (model.imageUrl != "")
                                        ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 22,
                                        backgroundImage:
                                        NetworkImage(model.imageUrl!))
                                        :
                                    const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 22,
                                        backgroundImage: AssetImage(
                                            "assets/images/extra/profilePic.png")),),
                                  Expanded(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15, left: 10),
                                      child: Text(
                                        (model.address == null)
                                            ? ""
                                            :model.address,
                                        style: AppTextStyles.popins(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 15),
                                    child: Text(
                                      (model.patientName == null)
                                          ? ""
                                          :"${model.patientName}"  ,
                                      style: AppTextStyles.popins(
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                    ),
                                  ),
                                  Text(
                                    "${model.serviceName.toString()} service",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.kDarkColor)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4, right: 4),
                                    child: Text(
                                      "-",
                                      style: AppTextStyles.popins(
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: AppColors.kDarkColor)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 2),
                                    child: Text(
                                      "${model.price.toString()} PKR",
                                      style: AppTextStyles.popins(
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.red)),
                                    ),
                                  ),
                                  Text(
                                    " ~",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.kDarkColor)),
                                  ),
                                  Text(
                                    (position == null)
                                        ? ""
                                        : calculateDistance(
                                        position!.latitude,
                                        position!.longitude,
                                        value.serviceRequest[index]
                                            .latitude,
                                        value.serviceRequest[index]
                                            .longitude)
                                        .toStringAsFixed(1),
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.kDarkColor)),
                                  ),
                                  Text(
                                    "km",
                                    style: AppTextStyles.popins(
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600)),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                  formattedTime,
                                  style: AppTextStyles.popins(
                                      style: const TextStyle(
                                          fontSize: 9,
                                          color: AppColors.kDarkColor)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: screenWidth * 0.93,
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.more_vert),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 36,
                                  color: AppColors.kPrimaryColor,
                                ),
                                Text(
                                  "Complain",
                                  style: AppTextStyles.popins(
                                      style: const TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 36,
                                  color: AppColors.kPrimaryColor,
                                ),
                                Text("Hide",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 14)))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 36,
                                  color: AppColors.kPrimaryColor,
                                ),
                                Text("Show on map",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 14)))
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                ));
          },
        );
      }),
    );
  }

  var first, second, third;
  var address;
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getAddress(latitude, longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      first = placemark[0].street;
      second = placemark[2].subLocality;
      third = placemark[0].locality;
      address = first + second + third;
    });
  }

  Position? position;
  setPosition() async {
    position = await getUserCurrentLocation();
    setState(() {
      position = position;
    });
  }
}
