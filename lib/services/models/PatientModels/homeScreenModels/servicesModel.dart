import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class PeramedicServicesModel {
  final String title;
  final String image;
  Widget? onTap;
  Color borderColor;
  int price;
  PeramedicServicesModel({
   this.onTap,
   required this.borderColor,
     required this.price,
     required this.title,
     required this.image,
  });
}