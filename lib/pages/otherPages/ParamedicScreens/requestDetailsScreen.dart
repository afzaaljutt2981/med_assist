// ignore_for_file: unnecessary_const

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/homeScreen.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/registerScreen.dart';

import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/services/models/PatientModels/getParamedicOffers.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../services/models/PatientModels/homeScreenModels/drowerProfileModel.dart';
import '../../../services/models/PatientModels/homeScreenModels/servicesModel.dart';

import '../../../services/models/PatientModels/senRequestModel.dart';
import '../../../services/utils/app_text_style.dart';

class AcceptPatientRequest extends StatefulWidget {
  ServiceModel currentService;

  AcceptPatientRequest({
    Key? key,
    required this.currentService,
  }) : super(key: key);

  @override
  State<AcceptPatientRequest> createState() => _AcceptPatientRequest();
}

class _AcceptPatientRequest extends State<AcceptPatientRequest> {

  // Camera Location


  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  @override
  void initState() {
    
    patientlng = widget.currentService.latitude;
    patientlng = widget.currentService.longitude;
    super.initState();
    getLoadData();
    setCustomMapPin();
  }
  var price;


  GoogleMapController? _mapController;


  bool showBottom = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      body: ChangeNotifierProvider<RegisterPeramedic>(
        create: (context) => RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    // Google Map
                    GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      markers: Set<Marker>.of(_markers),
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      tiltGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      mapType: MapType.terrain,
                      compassEnabled: true,
                      onMapCreated: (controller) {
                        _mapController = controller;
                        // showPinOnMap(value);
                        // For Black theme og map
                        //  _mapController!.setMapStyle(_mapStyle);
                      },
                    ),

                    Positioned(
                        left: 100,
                        child: Text(
                          "Service Requests",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ))
                  ],
                ),
              ),
              bottomSheetWidget(value),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetWidget(value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                      (widget.currentService.imageUrl == "")?
                       const CircleAvatar(
                      backgroundColor: Colors.white,
                       maxRadius: 30,
                      backgroundImage: AssetImage(
                        "assets/images/extra/profilePic.png")):
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              widget.currentService.imageUrl.toString()),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.currentService.patientName)
                      ],
                    ),
                     const Padding(
                       padding: EdgeInsets.only(left: 8, top: 10),
                       child: Icon( Icons.location_on, color: AppColors.kPrimaryColor, ),
                     ),
                      Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 7, top: 10),
                        child: Text(
                          widget.currentService.address,
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
            ),

            Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () async {
                      
                      LoadingDialogue.showLoaderDialog(context);
                      if( value.count<4 ){
                        Navigator.pop(context);
                          _showDialogueBoxProcced(context);
                      }
                      else{
                        int finalFee = 0;
                        finalFee = widget.currentService.price + doctorFee;
                        var doc = FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.currentService.uid)
                            .collection("paramedicRequests").doc(FirebaseAuth.instance.currentUser!.uid);
                        await value.giveServiceOffersToPatients(widget.currentService.uid, FirebaseAuth.instance.currentUser!.uid,value.user.image, latitude, longitude,
                        value.user.fName, finalFee, widget.currentService.serviceName, widget.currentService.uid
                        );
                        await Future.delayed(const Duration(seconds: 5));
                        // ignore: use_build_context_synchronously
                        await value.acceptingOffersofParamedics(
                          widget.currentService.uid, FirebaseAuth.instance.currentUser!.uid, context, widget.currentService, value
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: (widget.currentService.price > offeredFee)
                          ? Text(
                              "Accept for PKR ${widget.currentService.price}",
                              style: const TextStyle(fontSize: 16),
                            )
                          : Text(
                              "Accept for PKR $offeredFee",
                              style: const TextStyle(fontSize: 16),
                            ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Offer your rate",
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
                      if (doctorFee > 0) {
                        setState(() {
                          doctorFee = doctorFee - 50;
                        // widget.currentService.price = widget.currentService.price - doctorFee;
                         
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (doctorFee > 0)
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
                      //  widget.currentService.price = widget.currentService.price + doctorFee;
                       
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade100,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ParamedicHomeScreen()),
                          (route) => false);
                    },
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                              color: AppColors.kWhiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogueBoxProcced(BuildContext context) async  {
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
                              builder: (c) => const ParamedicRegistrationScreen()));
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
// Location Icon
setCustomMapPin() async {
  BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
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

      _markers.add(
        Marker(
            markerId: const MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            icon: pinLocationIcon!,
            infoWindow:
            InfoWindow(title: "${value.latitude}, ${value.longitude} ")),
      );
    });

    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude), zoom: 14);
    _mapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {});

    List<Placemark> placemark =
    await placemarkFromCoordinates(value.latitude, value.longitude);
    setState(() {
      first = placemark[0].street;
      second = placemark[3].street;
      third = placemark[0].locality;
    });

    return placemark;
  });
}

  // Camera Location
  static const CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(31.48399, 74.39522),
    zoom: 14,
  );
  bool isLoading = false;
  String? _mapStyle;
  int index = 0;
  int offeredFee = 0;
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  var first, second, third;
  String? serviceName;
  double latitude = 0.0;
  double longitude = 0.0;
  BitmapDescriptor? pinLocationIcon;
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  double? patientLat;
  double? patientlng;

  LatLng? destinationLocation;
  int doctorFee = 0;
}
