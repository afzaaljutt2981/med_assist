import 'package:flutter/material.dart';
class EndServiceModel{
  bool serviceCompleted;
  EndServiceModel({
    required this.serviceCompleted,
  });
  static EndServiceModel fromJson(Map<String,dynamic>Json)=>EndServiceModel(
      serviceCompleted: Json["serviceCompleted"]
  );
  Map<String,dynamic> toJson () =>
      {
        "serviceCompleted": serviceCompleted

      };
}