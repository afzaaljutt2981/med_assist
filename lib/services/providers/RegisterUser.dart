import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/Registrationscreens/basicInfo.dart';
import 'package:med_assist/pages/otherPages/ParamedicScreens/homeScreen.dart';
import 'package:med_assist/services/models/PatientModels/getParamedicOffers.dart';
import 'package:med_assist/services/models/PatientModels/homeScreenModels/drowerProfileModel.dart';

import '../../pages/otherPages/ParamedicScreens/goingForServiceScreen.dart';
import '../../pages/otherPages/PatientScreens/gattingServiceScreen.dart';
import '../../pages/otherPages/PatientScreens/patientHomeScreen.dart';
import '../../pages/otherPages/ratingScreen.dart';
import '../../pages/test.dart';
import '../models/PatientModels/end_service_model.dart';
import '../models/PatientModels/senRequestModel.dart';
import '../models/PeramedicModels/paramedic_rating_model.dart';
import '../models/PeramedicModels/servicesListModel.dart';
import '../models/chat_model.dart';

class RegisterPeramedic with ChangeNotifier {
  // checkAuth() {
  //   final auth = FirebaseAuth.instance;
  //   auth.authStateChanges().listen((event) async {
  //     if (event != null) {
  //    await  filterUserProducts();
  //     } else {}
  //   });
  // }
  RegisterPeramedic() {
    if (FirebaseAuth.instance.currentUser != null) {
      getCurrentUserData();
      getServicesRequests();
      getParamedicOffers();
      getPatientHistoryDetails();
      getParamedicServiceList();
      peramedicRegistrationConfirmation();
      paramedicServicesCount();
      paramedicReviewsCount();
      averageParamedicReviewsCounter();
    }
  }
  double userRatingStars = 0;
  var count = 1;
  double reviewsCounter = 0;
  var paramedicServicesCounter;
  var paramedicTotalReviewsCounter;
  DrawerProfileModel? user;
  DrawerProfileModel? pNumber;
  double? overAllReviews;
  var first, second, third;
  GetParamedicsOffers? model;
  EndServiceModel? ednService;
  var address;
  List<ServiceModel> serviceRequest = [];
  List<ServiceModel> getPatientHistory = [];
  List<GetParamedicsOffers> offers = [];
  List<ChatModel> chatScreenList = [];
  List<ParamedicServiceList> paramedicAllServiceList = [];
  ParamedicRatingModel? paramedicReview;
  var currentUserDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  var storedImages = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("paramedic");
  var getServiceRequests = FirebaseFirestore.instance
      .collection("services")
      .orderBy('time', descending: true);
  var addServiceRequests = FirebaseFirestore.instance
      .collection("services")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  var patientGetHistory = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("historyAsPatient");

  registerUser( TextEditingController fName,TextEditingController lName) async {
    print(fName.text);
    await FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
      {
        "firstName": fName.text,
        "lastName": lName.text,
      }
    );
    notifyListeners();
  }

  updateUserData({
    String? firstName,
    String? lName,
    DateTime? dob,
    String? email,
    String? image,
  }) async {
    await currentUserDoc.update({
      "firstName": firstName,
      "lastName": lName,
      "id": FirebaseAuth.instance.currentUser!.uid,
      'dob': dob!.millisecondsSinceEpoch,
      'profilePic': image,
      'email': email,
    });
    notifyListeners();
  }

  getCurrentUserData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      user = DrawerProfileModel.fromJson(event.data()!);
      notifyListeners();
    });
  }

  addService(
      {required String address,
      required double longitude,
      required double latitude,
      required String serviceName,
      required String image,
      required int price}) async {
    addServiceRequests.set(ServiceModel(
            address: address,
            time: DateTime.now().millisecondsSinceEpoch,
            patientName: user!.fName,
            longitude: longitude,
            latitude: latitude,
            serviceName: serviceName,
            price: price,
            imageUrl: image,
            uid: FirebaseAuth.instance.currentUser!.uid)
        .toJson());
  }

  patientHistory(
      {required String address,
      required double longitude,
      required double latitude,
      required String serviceName,
      required String image,
      required int price}) async {
    patientGetHistory.add(ServiceModel(
            address: address,
            time: DateTime.now().millisecondsSinceEpoch,
            patientName: user!.fName,
            longitude: longitude,
            latitude: latitude,
            serviceName: serviceName,
            price: price,
            imageUrl: image,
            uid: FirebaseAuth.instance.currentUser!.uid)
        .toJson());
  }

  getPatientHistoryDetails() {
    patientGetHistory.snapshots().listen((event) {
      getPatientHistory = [];
      for (var element in event.docs) {
        getPatientHistory.add(ServiceModel.fromJson(element.data()));
      }
      notifyListeners();
    });
  }

  getServicesRequests() {
    getServiceRequests.snapshots().listen((event) {
      serviceRequest = [];
      for (var element in event.docs) {
        serviceRequest.add(ServiceModel.fromJson(element.data()));
      }
      notifyListeners();
    });
  }

  giveServiceOffersToPatients(
      String patientId,
      String id,
      String image,
      double latitude,
      double longitude,
      String paramedicName,
      int price,
      String serviceName,
      String uid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(patientId)
        .collection("paramedicRequests")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(GetParamedicsOffers(
                id: id,
                image: image,
                latitude: latitude,
                longitude: longitude,
                paramedicName: paramedicName,
                price: price,
                serviceName: serviceName,
                uid: uid)
            .toJson());
  }

  getParamedicOffers() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("paramedicRequests")
        .snapshots()
        .listen(
      (event) {
        offers = [];
        for (var element in event.docs) {
          offers.add(GetParamedicsOffers.fromJson(element.data()));
        }
        notifyListeners();
      },
    );

    //  / notifyListeners();
  }

  deleteServiceRequest(String id) async {
    await FirebaseFirestore.instance.collection("services").doc(id).delete();
    notifyListeners();
  }

  paramedicRequestResponseAccept(String paramedicId, context,
      GetParamedicsOffers currentModel, RegisterPeramedic provider ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("paramedicRequests")
        .doc(paramedicId)
        .update({"patientResponse": true});
    paramedicEndService(
        FirebaseAuth.instance.currentUser!.uid, paramedicId, false);
    notifyListeners();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => PatientGettingServiceScreen(

                  currentModel: currentModel,
                  provider: provider,

                )));
  }

  paramedicRequestResponseDecline(String paramedicId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("paramedicRequests")
        .doc(paramedicId)
        .update({"patientResponse": false});
    notifyListeners();
  }
  acceptingOffersofParamedics( String patientId, String paramedicId, context,ServiceModel patientModel, RegisterPeramedic provider,)async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(patientId)
        .collection("paramedicRequests").doc(paramedicId).snapshots().listen((
        event) async {
      model = GetParamedicsOffers.fromJson(event.data()!);
      notifyListeners();
      if (model?.patientResponse == true){

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ParamedicServiceScreen(
              provider: provider,
                patientModel: patientModel
            )));
        FirebaseFirestore.instance.collection("users").doc( patientId ).collection("chatWithParamedics");
        getListOfChat(patientId);
      } else if (model?.patientResponse == false) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParamedicHomeScreen()));
      }
      else {
        Future.delayed(const Duration(seconds: 15));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParamedicHomeScreen()));
      }
    });
  }
  // acceptingOffersofParamedics(String patientId, String paramedicId, context,
  //     ServiceModel patientModel, RegisterPeramedic provider ) async {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(patientId)
  //       .collection("paramedicRequests")
  //       .doc(paramedicId)
  //       .snapshots()
  //       .listen((event) async {
  //     model = GetParamedicsOffers.fromJson(event.data()!);
  //     notifyListeners();
  //     if (model?.patientResponse == true) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   ParamedicServiceScreen(patientModel: patientModel, provider: provider, )));
  //       FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(patientId)
  //           .collection("chatWithParamedics");
  //       getListOfChat(patientId);
  //     } else if (model?.patientResponse == false) {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => ParamedicHomeScreen()));
  //     } else {
  //       Future.delayed(const Duration(seconds: 15));
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => ParamedicHomeScreen()));
  //     }
  //   });
  // }

  paramedicEndService(
    String patientId,
    String paramedicId,
    bool serviceCompleted,
  ) async {
    var endSer = FirebaseFirestore.instance
        .collection("users")
        .doc(patientId)
        .collection("endService")
        .doc(paramedicId);
    await endSer.set(EndServiceModel(
      serviceCompleted: serviceCompleted,
    ).toJson());
  }

  updateParamedicEndService(
    String patientId,
    String paramedicId,
  ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(patientId)
        .collection("endService")
        .doc(paramedicId)
        .update({"serviceCompleted": true});
  }

  Future<void> paramedicCompletedService(
      String patientId, GetParamedicsOffers paramedicId, context) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(patientId)
        .collection("endService")
        .doc(paramedicId.id)
        .snapshots()
        .listen((event) async {
      ednService = EndServiceModel.fromJson(event.data()!);
      notifyListeners();
      if (ednService?.serviceCompleted == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RatingParamedicScreen(
                      currentParamedic: paramedicId,
                    )));
      }
    });
  }



  getListOfChat( String id ){
    FirebaseFirestore.instance.collection("users").doc( id ).collection("chatWithParamedics").orderBy('timestamp', descending: false).snapshots()
        .listen(
          (event) {
        chatScreenList  = [];
        for (var element in event.docs) {
          chatScreenList.add(ChatModel.fromJson(element.data()));
        }
        notifyListeners();
      },
    );
  }

  paramedicServicesList(
    String address,
    String patientName,
    String serviceName,
    String price,
  ) async {
    var paramedicServices = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("servicesAsParamedic");
    await paramedicServices.add(ParamedicServiceList(
      address: address,
      time: DateTime.now().millisecondsSinceEpoch,
      patientName: patientName,
      price: price,
      serviceName: serviceName,
    ).toJson());
  }

  getParamedicServiceList() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("servicesAsParamedic")
        .orderBy('time', descending: true)
        .snapshots()
        .listen(
      (event) {
        paramedicAllServiceList = [];
        for (var element in event.docs) {
          paramedicAllServiceList
              .add(ParamedicServiceList.fromJson(element.data()));
        }
        notifyListeners();
      },
    );
  }

  deleteChatFunc(String id) async {
    CollectionReference firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("chatWithParamedics");
    await firestore.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    notifyListeners();
  }

  Future peramedicRegistrationConfirmation() async =>
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("RegisterAsParamedic")
          .get()
          .then((v) {
        count = v.docs.length;
        notifyListeners();
      });

  Future paramedicServicesCount() async => await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("servicesAsParamedic")
          .get()
          .then((v) {
        paramedicServicesCounter = v.docs.length;
        notifyListeners();
      });

  paramedicReviews(String paramedicId, double paramedicReviews) async {
    var endSer = FirebaseFirestore.instance
        .collection("users")
        .doc(paramedicId)
        .collection("ReviewsAsParamedic");
    await endSer.add(ParamedicRatingModel(
      paramedicReviews: paramedicReviews,
    ).toJson());
  }

  Future paramedicReviewsCount() async => await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("ReviewsAsParamedic")
          .get()
          .then((v) {
        paramedicTotalReviewsCounter = v.docs.length;
        notifyListeners();
      });

  averageParamedicReviewsCounter() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("ReviewsAsParamedic")
        .snapshots()
        .listen(
      (event) {
        if (paramedicTotalReviewsCounter != null) {
          for (var element in event.docs) {
            paramedicReview = ParamedicRatingModel.fromJson(element.data());
            reviewsCounter = reviewsCounter + paramedicReview!.paramedicReviews;
          }
          double num = paramedicTotalReviewsCounter.toDouble() * 5.0;
          overAllReviews = reviewsCounter / num * 5.0;
          notifyListeners();
        }
      },
    );
  }

  getPhoneNumbers(String docId ) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .snapshots()
        .listen((event) {
      pNumber = DrawerProfileModel.fromJson(event.data()!);
      notifyListeners();
    });
  }
}
