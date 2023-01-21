import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/services/models/PeramedicModels/basicInfoModel.dart';

import '../../models/PeramedicModels/cnic_model.dart';
import '../../models/PeramedicModels/documet_model.dart';
import '../../models/PeramedicModels/idVerificationModel.dart';

class ParamedicRegistration with ChangeNotifier {


  ParamedicRegistration() {
    getBasicInfo();
    getIdConfirmation();
    getCNICPics();
    getDocumentPics();
    peramedicRegistrationConfirmation();
  }

  var count = 1;
  int counter = 0;
  BasicInfoModel? infoUser;
  IdConfirmationModel? idConfirm;
  CnicModel? cnicVerify;
  DocumentModel? documentList;
  var currentUserDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('RegisterAsParamedic')
      .doc('information');
  var idConfirmationDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('RegisterAsParamedic')
      .doc('idConfirmation');
  var cnicVerficationDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('RegisterAsParamedic')
      .doc('cnicVerfication');
  var documentVerficationDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('RegisterAsParamedic')
      .doc('documentVerification');

  paramedicBasicInfo(String fname, String lName, int dob,
      String profileImage, String email) {
    currentUserDoc.set(BasicInfoModel(
            fname: fname,
            lName: lName,
            dob: dob,
            profileImage: profileImage,
            email: email)
        .toJson());
    notifyListeners();
  }

  peramedicRegistrationCnicFunction(
   {
     required String cnicFrontPicUrl,
    required String cnicBackPicUrl,
   }
  ) async {
    await cnicVerficationDoc.set(CnicModel(
            cnicBackPicUrl: cnicBackPicUrl, cnicFrontPicUrl: cnicFrontPicUrl)
        .toJson());
    notifyListeners();
  }

  peramedicRegistrationIDConfirmationFunction({
    required String idConfirmation,
  }) async {
    await idConfirmationDoc.set(
      IdConfirmationModel(idConfirmation: idConfirmation).toJson()
    );
    notifyListeners();
  }

  peramedicRegistrationDocumentsFunction({
    required String documentPic,
  }) async {
    await documentVerficationDoc.set(
      DocumentModel(documentPic: documentPic).toJson(),
    );
    notifyListeners();
  }

  getBasicInfo() {
    currentUserDoc.snapshots().listen((event) {
      if(event.data()!=null) {
        infoUser = BasicInfoModel.fromJson(event.data()!);
        notifyListeners();
      }
    });
  }

  getIdConfirmation() {
    idConfirmationDoc.snapshots().listen((event) {
      if(event.data()!=null){
      idConfirm = IdConfirmationModel.fromJson(event.data()!);
      notifyListeners();
      }
    });
  }

  getCNICPics() {

    cnicVerficationDoc.snapshots().listen((event) {
      if(event.data()!=null) {
        cnicVerify = CnicModel.fromJson(event.data()!);
        notifyListeners();
      }
    });
  }

  getDocumentPics() {
    documentVerficationDoc.snapshots().listen((event) {
      if(event.data()!=null) {
        documentList = DocumentModel.fromJson(event.data()!);
        notifyListeners();
      }
    });
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
}
