// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../services/models/PatientModels/getParamedicOffers.dart';
// import '../../services/models/PatientModels/senRequestModel.dart';
// import '../../services/models/chat_model.dart';
// import '../../services/providers/RegisterUser.dart';
// import '../../services/utils/colors.dart';
//
// class ChatScreen extends StatefulWidget {
//   String Name;
//   String image;
//   String id;
//   RegisterPeramedic provider;
//
//   // GetParamedicsOffers? paramedicModel;
//   ChatScreen(
//       {Key? key, required this.Name, required this.image, required this.id, required this.provider })
//       : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// var userId;
// TextEditingController textEditingController = TextEditingController();
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     super.initState();
//     userId = widget.id;
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.kSecondryColor,
//         flexibleSpace: Container(
//           padding: EdgeInsets.only(right: 16),
//           child: Row(
//             children: <Widget>[
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(
//                 width: 2,
//
//               ),
//               (widget.image == "")?
//               const CircleAvatar(
//                   backgroundColor: Colors.white,
//                   maxRadius: 20,
//                   backgroundImage: AssetImage(
//                       "assets/images/extra/profilePic.png")):
//               CircleAvatar(
//                 backgroundImage: NetworkImage(widget.image),
//                 maxRadius: 20,
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     widget.Name,
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   Text(
//                     "Online",
//                     style: TextStyle(
//                         color: Colors.grey.shade600, fontSize: 13),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: ChangeNotifierProvider(
//         create: (context)=>RegisterPeramedic(),
//         child: Consumer<RegisterPeramedic>(builder: (context, value, child) {
//           widget.provider.getListOfChat(userId);
//           print("this is chat${value.chatScreenList.length}");
//           return Stack(
//             children: <Widget>[
//               Container(
//                 child: (value.chatScreenList.isEmpty)
//                     ? const Center(child: Text("No messages yet"))
//                     : ListView.builder(
//                         itemCount: value.chatScreenList.length,
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           var getData = value.chatScreenList[index];
//                           return Container(
//                             padding: const EdgeInsets.only(
//                                 left: 14, right: 14, top: 10, bottom: 10),
//                             child: Align(
//                               alignment: ((getData.id ==
//                                       FirebaseAuth.instance.currentUser!.uid)
//                                   ? Alignment.topRight
//                                   : Alignment.topLeft),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: ((getData.id ==
//                                           FirebaseAuth
//                                               .instance.currentUser!.uid)
//                                       ? Colors.blue[200]
//                                       : Colors.grey.shade200),
//                                 ),
//                                 padding: EdgeInsets.all(16),
//                                 child: Text(
//                                   getData.message,
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//                   height: 60,
//                   width: double.infinity,
//                   color: Colors.white,
//                   child: Row(
//                     children: <Widget>[
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Expanded(
                        // child: TextFormField(
                        //   controller: textEditingController,
                        //   decoration: const InputDecoration(
                        //       hintText: "Write message...",
                        //       hintStyle: TextStyle(color: Colors.black54),
                        //       border: InputBorder.none),
                        // ),
//                       ),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       FloatingActionButton(
//                         onPressed: () async {
//
//                           var doc = widget.id;
//                           value.uploadChat(doc, textEditingController.text );
//                           setState(() {
//                             textEditingController.text = "";
//                           });
//
//                         },
//                         backgroundColor: (textEditingController.text == "")? Colors.grey.shade200 : Colors.blue,
//                         elevation: 0,
//                         child: const Center(
//                             child: Icon(
//                           Icons.send,
//                           color: Colors.white,
//                           size: 24,
//                         )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/providers/RegisterUser.dart';
import '../../services/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  String Name;
  String image;
  String id;
  RegisterPeramedic? provider;
  // GetParamedicsOffers? paramedicModel;
  ChatScreen(
      {Key? key, required this.Name, required this.image, required this.id, this.provider })
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

var userId;
TextEditingController textEditingController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    userId = widget.id;
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterPeramedic>(
      create: (context) => RegisterPeramedic(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.kSecondryColor,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  (widget.image == "")?
                  const CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 20,
                      backgroundImage: AssetImage(
                          "assets/images/extra/profilePic.png")):
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.Name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Consumer<RegisterPeramedic>(builder: (context, value, child) {
        value.getListOfChat(widget.id);
          return Stack(
            children: <Widget>[
              (value.chatScreenList.isEmpty)
                  ? const Center(child: Text("No messages yet"))
                  :  Container(
                height: MediaQuery.of(context).size.height *0.8,
                child: ListView.builder(
                itemCount: value.chatScreenList.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                 var getData = value.chatScreenList[index];
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: ((getData.id ==
                          FirebaseAuth.instance.currentUser!.uid)
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ((getData.id ==
                              FirebaseAuth
                                  .instance.currentUser!.uid)
                              ? Colors.blue[200]
                              : Colors.grey.shade200),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          getData.message,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          var doc = widget.id;
                          var model = FirebaseFirestore.instance
                              .collection("users")
                              .doc(doc)
                              .collection("chatWithParamedics");
                          model.add({
                            "id": FirebaseAuth.instance.currentUser!.uid,
                            "timestamp": FieldValue.serverTimestamp(),
                            "message": textEditingController.text,
                          });
                          setState(() {
                            textEditingController.text = "";
                          });
                        },
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 24,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
