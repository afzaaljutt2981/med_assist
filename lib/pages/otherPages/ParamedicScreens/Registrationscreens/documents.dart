import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import '../../../../services/providers/peramedic/registerParamedic.dart';
import '../../../../services/utils/app_text_style.dart';
import '../../../../services/utils/colors.dart';
import '../../../../services/widgets/PeramedicData/paramedicRegisterWidget.dart';
import '../registerScreen.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  String? documentPic;
  XFile? file;
  String uniqueNameClass = DateTime.now().millisecondsSinceEpoch.toString();
  String? document;



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,

      // Appbar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: ParamedicRegisterAppbar(
          screenName: "Documents",
        ),
      ),

      // body
      body: ChangeNotifierProvider(
        create: (context) => ParamedicRegistration(),
        child: Consumer<ParamedicRegistration>(
          builder: (context, value, child) => SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.12),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: screenWidth * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            "Documents Confirmation",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kDarkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                        )),
                        // Profile Pic
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              height: screenHeight * 0.35,
                              width: screenWidth * 0.7,
                              child: file == null
                                ? (value.documentList == null)?
                                  ClipRRect (
                                    
                                    borderRadius: BorderRadius.circular(20),
                                     child: const Image(
                                        image: AssetImage(
                                            "assets/images/extra/documentScan.jpg"),
                                            fit: BoxFit.cover,
                                      ),
                                   ):
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(value.documentList!.documentPic),
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(file!.path),
                                        fit: BoxFit.cover,
                                      )),
                            ),
                          ),
                        ),

                        // Add Photo container
                        Padding(
                          padding: const EdgeInsets.only(top: 7, bottom: 15),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                pickImageFromCamera();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: AppColors.kPrimaryColor,
                                        width: 2)),
                                //  color: Colors.red,
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.05,
                                child: Center(
                                  child: Text(
                                    "Add a Photo",
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Instructions
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            """Bring your Paramedic verified degree and take a photo as an example:\n
The photo should clearly show your name and editional details\n
The photo must be taken in good light and in good quality\n
Blury photos are not allowed""",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                              fontSize: 17,
                              color: AppColors.kDarkColor,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Next Button
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.87,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.kPrimaryColor,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)))),
                      onPressed: () async {
                        LoadingDialogue.showLoaderDialog(context);
                         documentPic = await uploadFile();
                         if(documentPic == null){
                           // ignore: use_build_context_synchronously
                           Navigator.pop(context);
                           // ignore: use_build_context_synchronously
                           newSnackBar(context,"Invalid Data" );
                         }
                        else{
                           await value.peramedicRegistrationDocumentsFunction(
                               documentPic: documentPic!);
                           // ignore: use_build_context_synchronously
                          Navigator.push(context,MaterialPageRoute(builder: (c)=>const ParamedicRegistrationScreen() ) );
                         }
                      },
                      child: Text(
                        "Next ",
                        style: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
                    )),

                // term and conditions
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                    width: screenWidth * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text.rich(
                      TextSpan(children: <TextSpan>[
                        // ignore: prefer_const_constructors
                        TextSpan(
                            text: 'If you have questions, please contact our\n',
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kDarkColor,
                                    fontSize: 12))),
                        // ignore: prefer_const_constructors
                        TextSpan(
                            text: 'customer support.',
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 12.5,
                                    decoration: TextDecoration.underline))),
                      ]),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: screenHeight * 0.04,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future uploadFile() async {
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference refrenceDirImages = referenceRoot
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("documents")
        .child(uniqueNameClass);

    try {
      await refrenceDirImages.putFile(File(file!.path));
      document = await refrenceDirImages.getDownloadURL();
      print(document);
    } catch (e) {
      print('error occured');
    }
    return document;
  }

  Future pickImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      file = image;
    });
  }
  void newSnackBar(BuildContext context, String text ) {
    final snackbaar = SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.black.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbaar);
  }
}
