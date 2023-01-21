// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class Register with ChangeNotifier {
//    List<RegisterModel> images = [];
//   Register(){
//     getImages();
//   }
//   var currentUserDoc = FirebaseFirestore.instance.collection('images');
// var image1Doc;
// var image2Doc;
 
//   storeCnicImages(
//     String pic1,
//     String pic2,
//   ) async {
//     await FirebaseFirestore.instance.collection("images").doc('cnic').set({
//       "pic1": pic1,
//       "pic2": pic2,
//     });
//   }

// getImages(){
//   FirebaseFirestore.instance
//         .collection("images").snapshots().listen((event) { 
//           for (var element in event.docs) { 
//             images.add(RegisterModel.fromJson(element.data()));
//             print(images.length);
//           }
    
//         });
//   notifyListeners();
// }
// }




// class RegisterModel{
//   String pic1;
//   String pic2;
//   RegisterModel({
//    required this.pic1, required this.pic2
//  } );

//   static RegisterModel fromJson(Map<String, dynamic> Json) =>
//   RegisterModel(
//     pic1: Json["pic1"],
//     pic2: Json["pic2"]
//   );
// }

















// import 'package:flutter/material.dart';
// class PeramedicServicesModel {
//   final String title;
//   final String image;
//   Widget? onTap;
//   Color borderColor;
//   PeramedicServicesModel({
//    this.onTap,
//    required this.borderColor,
//      required this.title,
//      required this.image,
//   });
// }