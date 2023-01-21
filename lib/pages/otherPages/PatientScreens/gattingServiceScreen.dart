import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_assist/pages/otherPages/chat_screen.dart';
import 'package:med_assist/services/models/PatientModels/getParamedicOffers.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/utils/app_text_style.dart';
import '../../test.dart';

class PatientGettingServiceScreen extends StatefulWidget {
  GetParamedicsOffers currentModel;
  RegisterPeramedic? provider;

  PatientGettingServiceScreen({
    Key? key, required this.currentModel,
    required this.provider,
  }) : super(key: key);

  @override
  State<PatientGettingServiceScreen> createState() => _PatientGettingServiceScreen();
}

class _PatientGettingServiceScreen extends State<PatientGettingServiceScreen> {
//  final Completer<GoogleMapController> _controller = Completer();
  RegisterPeramedic? provide;
  GetParamedicsOffers? model;
  bool isLoading = false;
  String? _mapStyle;
  int index = 0;
  int offeredFee = 0;

  get screenHeight =>
      MediaQuery
          .of(context)
          .size
          .height;

  get screenWidth =>
      MediaQuery
          .of(context)
          .size
          .width;
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
  @override
  void initState() {
    widget.provider?.paramedicCompletedService(
        FirebaseAuth.instance.currentUser!.uid, widget.currentModel, context);
      widget.provider?.getPhoneNumbers(widget.currentModel.id);
      widget.provider?.pNumber?.phoneNumber;
    // patientlng = widget.currentService.latitude;
    //  patientlng = widget.currentService.longitude;
    super.initState();
    getLoadData();
    setCustomMapPin();
  }
  var price;
  final List<Marker> _markers = <Marker>[];
  GoogleMapController? _mapController;
  bool showBottom = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kSecondryColor,
        actions: [
          TextButton(
              onPressed: () {

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
      backgroundColor: AppColors.kSecondryColor,
      body: ChangeNotifierProvider<RegisterPeramedic>(
        create: (context) => RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(
          builder: (context, value, child) {
            provide = value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

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
                        },
                      ),

                      Positioned(
                          top: 10,
                          left: 20,
                          child: Text(
                            "${widget.currentModel
                                .paramedicName} accepted request for",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    fontSize: 22)),
                          )),
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Text(
                            widget.currentModel.price.toString(),
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                )),
                          )),
                    ],
                  ),
                ),
                bottomSheetWidget(value ),
              ],
            );
          },
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text("${widget.currentModel.serviceName} Service",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  )
              ),),
          ),
          Container(

            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: (widget.currentModel.image == "")?
                      const CircleAvatar(
                      backgroundColor: Colors.white,
                    maxRadius: 25,
                     backgroundImage: AssetImage(
                    "assets/images/extra/profilePic.png")):
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            widget.currentModel.image),
                      ),
                    ),
                    Text(widget.currentModel.paramedicName,
                      style: AppTextStyles.popins(
                          style: const TextStyle(
                            color: AppColors.kDarkColor,
                            fontSize: 14,
                          )
                      ),),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kPrimaryColor
                        ),
                        child: IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (c) => ChatScreen(
                                Name: widget.currentModel.paramedicName,
                                image: widget.currentModel.image,
                                id: FirebaseAuth.instance.currentUser!.uid,
                            provider: value,
                            //  provider: value,
                              )));
                        },
                          icon: const Icon(Icons.message,),
                          color: Colors.white,),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kPrimaryColor
                        ),
                        child: IconButton(onPressed: () {
                          setState(() {
                            final Uri uri = Uri(
                                scheme: 'tel',
                                path: '0${widget.provider!.pNumber?.phoneNumber}'
                            );
                            _launchUrl(uri);

                          });
                        },
                          icon: const Icon(Icons.call,),
                          color: Colors.white,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Camera Location
  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(31.48399, 74.39522),
    zoom: 14,
  );
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
  Future<void> _launchUrl (Uri uri) async {
    try {
      if (await canLaunchUrl(uri )) {
        await launchUrl(uri);
      }
      else {
        throw 'Could not launch $uri';
      }
    } catch (_){}
  }
}
