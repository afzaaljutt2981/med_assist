import 'package:firebase_auth/firebase_auth.dart';
class ParamedicServiceList{
  String patientName;
  String price;
  String serviceName;
  int time;
  String address;

  ParamedicServiceList({
    required this.address,
    required this.time,
    required this.patientName,
    required this.serviceName,
    required this.price,
  });
  static ParamedicServiceList fromJson(Map<String,dynamic>Json)=>ParamedicServiceList(
      time: Json["time"],
      patientName: Json["patientName"],
      serviceName: Json["serviceName"],
      price: Json["price"],
      address: Json["address"],
  );
  Map<String,dynamic> toJson () =>
      {
        "patientName":patientName,
        "serviceName":serviceName,
        "price":price,
        "time":time,
        "address":address,
      };
}