// ignore_for_file: unnecessary_const

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/homeScreen.dart';
import 'package:med_assist/services/models/PatientModels/getParamedicOffers.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/models/PatientModels/senRequestModel.dart';
import '../../../services/utils/app_text_style.dart';
import '../chat_screen.dart';

class ParamedicServiceScreen extends StatefulWidget {
  ServiceModel patientModel;
  RegisterPeramedic provider;
  ParamedicServiceScreen({
    Key? key,
  required this.patientModel,
    required this.provider
  }) : super(key: key);

  @override
  State<ParamedicServiceScreen> createState() => _ParamedicServiceScreen();
}

class _ParamedicServiceScreen extends State<ParamedicServiceScreen> {
  void initState() {
     widget.provider.getPhoneNumbers(widget.patientModel.uid!);
    // patientlng = widget.currentService.latitude;
    //  patientlng = widget.currentService.longitude;
    super.initState();
    getLoadData();
    setCustomMapPin();
  }
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
          builder: (context, value, child) => Column(
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
                        child: Container(
                          child: Text(
                            "you accepted request for",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                     fontSize: 22)),
                          ),
                        )),
                    Positioned(
                        top: 35,
                        left: 20,
                        child: Text(
                          widget.patientModel.price.toString(),

                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              )),
                        )),
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

  Widget bottomSheetWidget(value ) {
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
      child: Expanded(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text("${ widget.patientModel.serviceName } Service",style: AppTextStyles.popins(
              style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
            ), ),
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
                       child:
                       (widget.patientModel.imageUrl == "")?
                       const CircleAvatar(
                           backgroundColor: Colors.white,
                           maxRadius: 25,
                           backgroundImage: AssetImage(
                               "assets/images/extra/profilePic.png")):
                       CircleAvatar(
                         radius: 25,
                         backgroundImage: NetworkImage(widget.patientModel.imageUrl! ),
                       ),
                     ) ,
                    Text( widget.patientModel.patientName ,style: AppTextStyles.popins(
                      style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontSize: 14,
                      )
                    ), ),
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
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> ChatScreen(Name: widget.patientModel.patientName, image: widget.patientModel.imageUrl!, id: widget.patientModel.uid!,provider: value,  ) ));
                        }, icon:const Icon(Icons.message, ), color: Colors.white,),
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
                        child: IconButton(onPressed: (){
                             setState(() {
                                final Uri uri = Uri(
                            scheme: 'tel',
                            path: '0${widget.provider.pNumber?.phoneNumber}'
                           );
                           _launchUrl(uri);
                             
                             });
                        }, icon:const Icon(Icons.call, ), color: Colors.white,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.kPrimaryColor,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20)))),
                  onPressed: ()async {
                    LoadingDialogue.showLoaderDialog(context);
                    await value.updateParamedicEndService(widget.patientModel.uid,FirebaseAuth.instance.currentUser!.uid);
                    await  value.paramedicServicesList ( widget.patientModel.address ,widget.patientModel.patientName,widget.patientModel.serviceName,widget.patientModel.price.toString() );
                  //  await value.deleteServiceRequest( widget.patientModel.uid );
                    await value.deleteChatFunc(widget.patientModel.uid);
                      // ignore: use_build_context_synchronously
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ParamedicHomeScreen() ));
                      },
                  child: Text(
                    "Service Complete",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            color: AppColors.kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                )) ,
          ),
          const SizedBox(
            height: 30
          )
        ],
      )
      ),
    );
  }

  static const CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(31.48399, 74.39522),
    zoom: 14,
  );

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

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
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

  GetParamedicsOffers? model;
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
  var price;
  final List<Marker> _markers = <Marker>[];
  GoogleMapController? _mapController;
  bool showBottom = true;


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
