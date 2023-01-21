import 'package:flutter/material.dart';

class GetParamedicsOffers {
   String paramedicName;
   String image;
  double latitude;
  double longitude;
  int price;
  String serviceName;
  String id;
  String uid;
  bool? patientResponse;
//  int? dob;

  GetParamedicsOffers({
    required this.id,
    this.patientResponse,
     required this.image,
     required this.latitude,
     required this.longitude,
     required this.paramedicName,
     required this.price,
     required this.serviceName,
     required this.uid,
     
  });
  Map<String,dynamic> toJson () =>
      {
        "patientResponse": patientResponse,
        "id": id,
        "paramedicName": paramedicName,
        "imageUrl": image,
        "latitude": latitude,
        "longitude": longitude,
        "price": price,
        "serviceName": serviceName,
        "uid": uid
      };

  static GetParamedicsOffers fromJson (Map<String, dynamic> Json) => 
  GetParamedicsOffers(
    patientResponse: Json["patientResponse"],
    id: Json["id"],
    paramedicName: Json["paramedicName"],
    image: Json["imageUrl"],
    latitude: Json["latitude"],
    longitude: Json["longitude"],
    price: Json["price"],
    serviceName: Json["serviceName"],
    uid: Json["uid"]
  );

}