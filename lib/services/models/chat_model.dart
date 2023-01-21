import 'package:flutter/cupertino.dart';


class ChatModel {
  String id;
  String message;

  ChatModel ({
    required this.id,
    required this.message

  });

  static ChatModel fromJson (Map<String, dynamic> Json) =>
      ChatModel(
        id: Json["id"],
        message: Json["message"],

      );
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
//
// class ChatModel {
//   String id;
//   String message;
//   int timestamp;
//
//    ChatModel ({
//     required this.id,
//      required this.message,
//      required this.timestamp,
//
//   });
//   Map<String,dynamic> toJson () =>
//       {
//         "id": id,
//         "message": message,
//         "timestamp": timestamp
//
//       };
//   static ChatModel fromJson (Map<String, dynamic> Json) =>
//       ChatModel(
//           id: Json["id"],
//         message: Json["message"],
//         timestamp: Json["timestamp"]
//
//       );
//
// }