import 'package:flutter/material.dart';

class DrawerProfileModel {
   String fName;
  String lName;
   String ?image;
  String id;
  String phoneNumber;
  Widget? widget;
  String? email;

  DrawerProfileModel({
     required this.fName,
      required this.lName,
     required this.phoneNumber,
     required this.id,
     this.image,
     this.email,
     this.widget,
     
  });

  static DrawerProfileModel fromJson (Map<String, dynamic> Json) => 
  DrawerProfileModel(
    fName: Json['firstName'],
    lName: Json['lastName'],
    id: Json['id'],
    phoneNumber: Json['phoneNumber'],
    image: Json['profilePic'],
    email: Json['email'],
  );
   Map<String,dynamic> toJson () =>
       {
         "firstName": fName,
         "lastName": lName,
         "id": id,
         "phoneNumber": phoneNumber,
         "profilePic": image,
         "email": email,

       };
}

class EditPatientProfileModel {
  final String firstName;
  final IconData icon;
  Widget? widget;
  EditPatientProfileModel({
     required this.firstName,
     required this.icon,
     this.widget,
     
  });


}


