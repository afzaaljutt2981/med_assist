import 'package:flutter/material.dart';
class ParamedicRatingModel{
  double paramedicReviews;
  ParamedicRatingModel({
    required this.paramedicReviews,
  });


  static ParamedicRatingModel fromJson(Map<String,dynamic> Json)=>ParamedicRatingModel(
      paramedicReviews: Json["paramedicReviews"]
  );
  Map<String,dynamic> toJson () =>
      {
        "paramedicReviews": paramedicReviews

      };
}