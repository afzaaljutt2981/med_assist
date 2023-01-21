import 'package:firebase_auth/firebase_auth.dart';

class ServiceModel{
  String patientName;
  double latitude;
  double longitude;
  String? imageUrl;
  int price;
  String serviceName;
  String? comment;
  int time;
  String address;
  String? uid;
  
  ServiceModel({
    required this.address,
    required this.time,
 required this.patientName,
 required this.longitude,
    required this.latitude,
    required this.serviceName,
    required this.price,
    this.comment,
 this.imageUrl,
  this.uid

});
  Map<String,dynamic> toJson () =>
      {
        "patientName":patientName,
        "latitude":latitude,
        "longitude":longitude,
        "serviceName":serviceName,
        "price":price,
        "imageUrl":imageUrl,
        "comment":comment,
        "time":time,
        "address":address,
        "uid": FirebaseAuth.instance.currentUser!.uid
      };
 static ServiceModel fromJson(Map<String,dynamic>Json)=>ServiceModel(
      time: Json["time"],
      patientName: Json["patientName"],
      longitude: Json["longitude"],
      latitude: Json["latitude"],
      serviceName: Json["serviceName"],
      price: Json["price"],
      imageUrl: Json["imageUrl"],
      comment: Json["comment"],
      address: Json["address"],
      uid: Json["uid"]
      
  );

}