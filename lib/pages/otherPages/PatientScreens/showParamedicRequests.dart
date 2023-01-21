// ignore_for_file: unnecessary_const

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/services/models/PatientModels/homeScreenModels/drowerProfileModel.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:med_assist/services/widgets/paramedics_offers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../services/models/PatientModels/homeScreenModels/servicesModel.dart';
import '../../../services/utils/app_text_style.dart';
import 'gattingServiceScreen.dart';

class ShowParamedicRequests extends StatefulWidget {
  int fee;
  ShowParamedicRequests({Key? key, required this.fee, required this.user})
      : super(key: key);
  DrawerProfileModel user;
  @override
  State<ShowParamedicRequests> createState() => _ShowParamedicRequests();
}

class _ShowParamedicRequests extends State<ShowParamedicRequests> {
  @override
  void initState() {
    super.initState();
    getLoadData();
    doctorFee = widget.fee;
    // Map Style Json Location
    rootBundle
        .loadString('assets/googleMapStyles/map_style.json')
        .then((string) {
      _mapStyle = string;
    });

    // Location Custom Picture
    setCustomMapPin();
  }

  var commentAndWishes;

  var price;
  final List<Marker> _markers = <Marker>[];
  GoogleMapController? _mapController;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<RegisterPeramedic>(
        create: (context) => RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
          builder: (context, value, child) => Scaffold(
            backgroundColor: AppColors.kSecondryColor,
            appBar: AppBar(
              backgroundColor: AppColors.kSecondryColor,
              actions: [
                TextButton(
                    onPressed: () {
                      //_showDialogueBoxRequests(context, value);
                      _showDialogueBoxClose(context, value);
                    },
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.popins(
                          style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 18,
                      )),
                    ))
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Google Map
                      GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        markers: Set<Marker>.of(_markers),
                        myLocationEnabled: true,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        mapType: MapType.terrain,
                        compassEnabled: true,
                        onMapCreated: (controller) {
                          _mapController = controller;
                          // For Black theme og map
                          //  _mapController!.setMapStyle(_mapStyle);
                        },
                      ),

                       // offers
                      if (value.offers.isNotEmpty) offers(value),
                    ],
                  ),
                ),
                if (value.offers.isEmpty) bottomSheetWidget(value)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialogueBoxClose(BuildContext context, value) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "Are you sure you want to cancel?",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor, fontSize: 18)),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 20),
                    )),
                TextButton(
                    onPressed: () async {
                      LoadingDialogue.showLoaderDialog(context);
                      await value.deleteServiceRequest(FirebaseAuth.instance.currentUser!.uid );
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 20),
                    )),
              ],
            ),
          );
        });
  }

  Widget myCurrentLocationButton() {
    return Container(
        width: 50,
        height: 45,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ], color: Colors.white, shape: BoxShape.circle),
        child: IconButton(
            onPressed: () {
              getLoadData();
            },
            icon: const Icon(
              Icons.location_on,
              color: AppColors.kPrimaryColor,
            )));
  }

  Widget bottomSheetWidget(value) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, bottom: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.kPrimaryColor,
                    size: 23,
                  ),
                  Expanded (
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        (first == null)
                            ? "pick your location "
                            : "$first, $second,  $third ",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                          color: AppColors.kDarkColor,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Current Fee",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (doctorFee > widget.fee) {
                        setState(() {
                          doctorFee = doctorFee - 50;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (doctorFee > widget.fee)
                              ? AppColors.kPrimaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Text(
                          "- 50",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "PKR ${(doctorFee.toString())}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        doctorFee = doctorFee + 50;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Text(
                          "+ 50",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (doctorFee < widget.fee || doctorFee == widget.fee)
                        ? Colors.grey.shade100
                        : AppColors.kPrimaryColor,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            (doctorFee < widget.fee || doctorFee == widget.fee)
                                ? Colors.grey.shade300
                                : AppColors.kPrimaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    onPressed: () async {
                      if (doctorFee > widget.fee) {
                        setState(() {
                          widget.fee = doctorFee;
                        });
                        CollectionReference user =
                            FirebaseFirestore.instance.collection('services');
                        await user
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(
                          {"price": widget.fee},
                        );
                      }
                    },
                    child: Text(
                      "Raise fee",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kWhiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget offers(value) {
    return Container(
      height: screenHeight,
      child: ListView.builder(
        itemCount: value.offers.length,
        itemBuilder: (context, index) {
          var model = value.offers[index];
          return OffersWidget(
            model: model,
            user: widget.user,
            onPressed: () async {
               await value.deleteServiceRequest(FirebaseAuth.instance.currentUser!.uid );
              FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("endService").doc(value.offers[index].id);
              await value.paramedicRequestResponseAccept(
                value.offers[index].id, context, value.offers[index],value,
                 

              );
            },
            onPress: () async {
              await value.paramedicRequestResponseDecline(
                value.offers[index].id,
              );
            },
          );
        },
      ),
    );
  }

  // Camera Location
  static const CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(31.48399, 74.39522),
    zoom: 14,
  );
  // Location Icon
  setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
        'assets/images/homeScreen/locationIcon.png')
        .then((d) {
      pinLocationIcon = d;
    });
  }

  // get user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  getLoadData() {
    getUserCurrentLocation().then((value) async {
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
      });
      print("${value.latitude} ${value.longitude}");
      _markers.add(
        Marker(
            markerId: const MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            icon: pinLocationIcon!,
            infoWindow:
            InfoWindow(title: "${value.latitude}, ${value.longitude} ")),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});

      List<Placemark> placemark =
      await placemarkFromCoordinates(value.latitude, value.longitude);
      print(placemark);
      setState(() {
        first = placemark[0].street;
        second = placemark[3].street;
        third = placemark[0].locality;
      });

      return placemark;
    });
  }

  bool showBottom = false;
  Marker? _centerMarker;
  String? _mapStyle;
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  var first, second, third;
  String? serviceName;
  double latitude = 0.0;
  double longitude = 0.0;
  BitmapDescriptor? pinLocationIcon;
  int doctorFee = 0;

}

