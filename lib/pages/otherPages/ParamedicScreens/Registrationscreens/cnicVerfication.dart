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

class CnicVerfication extends StatefulWidget {
  const CnicVerfication({Key? key}) : super(key: key);
  @override
  State<CnicVerfication> createState() => _CnicVerficationState();
}

class _CnicVerficationState extends State<CnicVerfication> {
  String? backPicUrl1;
  String? frontPicUrl1;

  XFile? frontSide;
  Future pickImageCnicFront() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      frontSide = image;
    });
  }

  XFile? backSide;
  Future pickImageCnicBack() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      backSide = image;
    });
  }

  String? cnicFrontPicUrl;
  Future uploadFrontCnic() async {
    String uniqueNameClass = DateTime.now().millisecondsSinceEpoch.toString();
    if (frontSide == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference refrenceDirImages = referenceRoot
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("cnic")
        .child(uniqueNameClass);

    try {
      await refrenceDirImages.putFile(File(frontSide!.path));
      cnicFrontPicUrl = await refrenceDirImages.getDownloadURL();
      print(cnicFrontPicUrl);
    } catch (e) {
      print('error occured');
    }
    return cnicFrontPicUrl;
  }

  String? cnicBackPicUrl;
  Future uploadBackCnic() async {
    String uniqueNameClass = DateTime.now().millisecondsSinceEpoch.toString();
    if (backSide == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference refrenceDirImages = referenceRoot
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("cnic")
        .child(uniqueNameClass);

    try {
      await refrenceDirImages.putFile(File(backSide!.path));
      cnicBackPicUrl = await refrenceDirImages.getDownloadURL();
      print(cnicBackPicUrl);
    } catch (e) {
      print('error occured');
    }
    return cnicBackPicUrl;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // Appbar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ParamedicRegisterAppbar(
          screenName: "CNIC",
        ),
      ),

      body: ChangeNotifierProvider<ParamedicRegistration>(
        create: (context) => ParamedicRegistration(),
        child: Consumer<ParamedicRegistration>(
          builder: (context, value, child) => SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.04),

                // CNIC FRONT
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
                          padding: const EdgeInsets.only(top: 4, bottom: 5),
                          child: Text(
                            "CNIC (front side)",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kDarkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        )),
                        // Profile Pic
                        Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.8,
                              child: frontSide == null?
                              (value.cnicVerify == null)?
                                   const Image(
                                      image: AssetImage(
                                          "assets/images/extra/cnicfront.jpg"),
                                      fit: BoxFit.cover):
                             ClipRRect (
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image(
                                  image: NetworkImage(value.cnicVerify!.cnicFrontPicUrl),
                                   fit: BoxFit.cover))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(File(frontSide!.path),
                                          fit: BoxFit.cover),
                                    )),
                        ),

                        // Add Photo container
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 15),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                pickImageCnicFront();
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
                      ],
                    ),
                  ),
                ),

                // CNIC BACK
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
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "CNIC (back side)",
                            style: AppTextStyles.popins(
                                style: const TextStyle(
                                    color: AppColors.kDarkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        )),
                        // Profile Pic
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.8,
                              child: backSide == null?
                              (value.cnicVerify == null )?
                                   const Image(
                                      image: AssetImage(
                                          "assets/images/extra/cnicback.jpg"),
                                      fit: BoxFit.cover):
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                       image: NetworkImage(value.cnicVerify!.cnicBackPicUrl),
                                       fit: BoxFit.cover),
                                  )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(backSide!.path),
                                        fit: BoxFit.cover,
                                      ))),
                        ),

                        // Add Photo container
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 15),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                pickImageCnicBack();
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
                         frontPicUrl1 = await uploadFrontCnic();
                         backPicUrl1 = await uploadBackCnic();
                         if(frontPicUrl1 == null || backPicUrl1 == null ){
                           // ignore: use_build_context_synchronously
                           Navigator.pop(context);
                           newSnackBar(context,"Invalid Data" );
                         }
                       else{
                           await value.peramedicRegistrationCnicFunction(
                               cnicFrontPicUrl: frontPicUrl1!,
                               cnicBackPicUrl: backPicUrl1!);

                           // ignore: use_build_context_synchronously
                           Navigator.pop(context);
                           // ignore: use_build_context_synchronously
                           newSnackBar(context, "data saved");
                         }
                      },
                      child: Text(
                        "Done ",
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
                                style: TextStyle(
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
  void newSnackBar(BuildContext context, String text ) {
    final snackbaar = SnackBar(
        duration: const Duration(milliseconds: 2000),
       // backgroundColor: Colors.black.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          child: Text(text),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbaar);
  }
}
