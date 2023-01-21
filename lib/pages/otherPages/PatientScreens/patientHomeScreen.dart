// ignore_for_file: unnecessary_const

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/showParamedicRequests.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../services/models/PatientModels/homeScreenModels/servicesModel.dart';
import '../../../services/utils/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isLoading = false;
var liveLocation;
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getLoadData();
    // Map Style Json Location
    // rootBundle
    //     .loadString('assets/googleMapStyles/map_style.json')
    //     .then((string) {
    //   _mapStyle = string;
    // });
    // Location Custom Picture
    setCustomMapPin();
  }
  var commentAndWishes;
  var price;
  final List<Marker> _markers = <Marker>[];


  GoogleMapController? _mapController;

  // Camera Location
  static const CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(31.48399, 74.39522),
    zoom: 14,
  );
  bool showBottom = true;
  @override
  bool newUser = false;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        drawer: const PatientDrawer(),
        body: ChangeNotifierProvider<RegisterPeramedic>(
          create: (context) => RegisterPeramedic(),
          child: Consumer<RegisterPeramedic>(builder: (context, value, child) {
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
                          // For Black theme og map
                          _mapController!.setMapStyle(_mapStyle);
                        },
                        onCameraMoveStarted: () {
                          setState(() {
                            showBottom = false;
                          });
                        },
                        onCameraIdle: () {
                          setState(() {
                            showBottom = true;
                          });
                        },
                      ),

                      // Menu Items
                      showBottom ? menuItems() : Container(),

                      Positioned(
                          right: 15,
                          bottom: 15,
                          child: showBottom
                              ? myCurrentLocationButton()
                              : Container())
                    ],
                  ),
                ),
                if (showBottom) bottomSheetWidget(value),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget menuItems() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Drawer
          Container(
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
              child: Builder(builder: (context) {
                return IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.kPrimaryColor,
                    ));
              })),

          // Share Icon
          Container(
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
                    Share.share(
                        " https://play.google.com/store/apps/details?id=com.example.med_assist ");
                  },
                  icon: const Icon(
                    Icons.share,
                    color: AppColors.kPrimaryColor,
                  ))),
        ],
      ),
    );
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
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
              // Med Assist Services
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  height: 78,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: servicesList.length,
                    itemBuilder: (context, index) {
                      price ??= servicesList[0].price;
                      var model = servicesList[index];
                      serviceName ??= servicesList[0].title;
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              serviceName = servicesList[index].title;
                              price = servicesList[index].price;
                              servicesList.forEach((element) {
                                element.borderColor = Colors.white;
                              });
                              servicesList[index].borderColor =
                                  AppColors.kPrimaryColor;
                            });
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: servicesList[index].borderColor,
                                    width: 3),
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                          width: 88,
                                          height: 33,
                                          child: Image(
                                              image: AssetImage(model.image)))),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(model.title,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.popins(
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.kDarkColor))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Current Location
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child:   Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.kPrimaryColor,
                      size: 23,
                    ),
                     Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child:
                         Text(
                           (first == null)
                               ? "pick your location "
                               : "$first, $second, $third",
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

              // Divider
              const Padding(
                padding: EdgeInsets.only(left: 33, right: 25, top: 3),
                child: Divider(
                  thickness: 0.5,
                  color: AppColors.kDarkColor,
                ),
              )

              // Price
              ,
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "PKR ",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                            color: AppColors.kDarkColor,
                            fontSize: 18,
                          )),
                        ),
                        Text(
                          "${price.toString()}",
                          style: AppTextStyles.popins(
                              style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 18,
                          )),
                        ),
                        Text(
                          ", cash",
                          style: AppTextStyles.popins(
                              style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        "Recomanded fare, adjustable",
                        style: AppTextStyles.popins(
                            style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 10,
                        )),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              const Padding(
                padding: EdgeInsets.only(left: 33, right: 25, top: 2),
                child: Divider(
                  thickness: 0.5,
                  color: AppColors.kDarkColor,
                ),
              ),

              // Text Field
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat,
                      color: AppColors.kDarkColor,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: InkWell(
                        onTap: () {
                          commentAndWishesWidget();
                        },
                        child: Text(
                          newUser ? commentAndWishes : "Comment and Wishes",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                            color: AppColors.kDarkColor,
                            fontSize: 14,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 33, right: 25, top: 5),
                child: Divider(
                  thickness: 0.5,
                  color: AppColors.kDarkColor,
                ),
              ),


              // Find a Paramedic Button
              Center(
                child: Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.kPrimaryColor,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                      onPressed: () async {
                          (value.user!.image == "")
                            ? imageUrl = ""
                            : imageUrl = value.user.image;

                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        //Future.delayed(const Duration(seconds: 6));
                        await value.addService(
                            longitude: long,
                            latitude: lat,
                            address: "$first, $second, $third",
                            serviceName: serviceName,
                            price: price,
                            image: imageUrl);
                        await value.patientHistory(
                            longitude: long,
                            latitude: lat,
                            address: "$first, $second, $third",
                            serviceName: serviceName,
                            price: price,
                            image: imageUrl);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ShowParamedicRequests(
                                    user: value.user,
                                      fee: price,
                                    )),
                            (route) => false);
                      },
                      child: Text(
                        "Find a Paramedic",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              )
            ],

          ),
        ),
      ),
    );
  }

  TextEditingController comentAndWishesController = TextEditingController();
  void commentAndWishesWidget() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  controller: comentAndWishesController,
                  style: const TextStyle(color: Colors.black),
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // ignore: prefer_const_constructors
                      prefixIcon: Icon(
                        Icons.chat,
                        color: AppColors.kPrimaryColor,
                      ),
                      hintText: "Comment and wishes",
                      hintStyle: AppTextStyles.popins(
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.kDarkColor))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          )),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            newUser = true;
                            commentAndWishes = comentAndWishesController.text;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text(
                          "Done",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          )),
                        ))
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  Widget medAssistServices(image, String text, {required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                      width: 85,
                      height: 38,
                      child: Image(image: AssetImage(image)))),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.kDarkColor))),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      lat = value.latitude;
      long = value.longitude;
      _markers.add(
        Marker(
            markerId: MarkerId('1'),
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
      setState(() {
        first = placemark[0].street;
        second = placemark[3].street;
        third = placemark[0].locality;
      });
      liveLocation = placemark;
      return placemark;
    });
  }

  final List<PeramedicServicesModel> servicesList = [
    PeramedicServicesModel(
        title: "INJECTION",
        borderColor: AppColors.kPrimaryColor,
        image: "assets/images/homeScreen/Injection.png",
        price: 1000),
    PeramedicServicesModel(
        title: "DRIP",
        borderColor: Colors.white,
        image: "assets/images/homeScreen/drip.png",
        price: 800),
    PeramedicServicesModel(
        title: "BANDAGES",
        borderColor: Colors.white,
        image: "assets/images/homeScreen/Bandage.png",
        price: 900),
    PeramedicServicesModel(
        title: "PHYSIO",
        borderColor: Colors.white,
        image: "assets/images/homeScreen/physio.png",
        price: 1200)
  ];

  Marker? _centerMarker;
  String? _mapStyle;
  String? serviceName;
  double? lat;
  double? long;
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  var first, second, third;
  String? imageUrl;
  BitmapDescriptor? pinLocationIcon;

}
