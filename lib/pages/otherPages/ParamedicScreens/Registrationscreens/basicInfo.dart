import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
import 'package:med_assist/services/utils/colors.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:med_assist/services/widgets/text_fields.dart';
import 'package:provider/provider.dart';
import '../../../../services/providers/peramedic/registerParamedic.dart';
import '../../../../services/widgets/PeramedicData/paramedicRegisterWidget.dart';
import '../registerScreen.dart';

class BasicInfo extends StatefulWidget {
  BasicInfo({Key? key,required this.fName, required this.lName, required this.emal  }) : super(key: key);
String fName;
String lName;
String emal;
  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

final _forkey = GlobalKey<FormState>();
DateTime selectedDate = DateTime.now();
TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController dob = TextEditingController();
TextEditingController email = TextEditingController();

class _BasicInfoState extends State<BasicInfo> {
  String? profilePicUrl;
  XFile? file;
  Future pickImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = image;
    });
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fname.text = widget.fName;
    lname.text = widget.lName;
    email.text = widget.emal;
  }
  @override
  Future pickImageFromGallery() async {
    XFile? oimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = oimage;
    });
  }

  String uniqueNameClass = DateTime.now().millisecondsSinceEpoch.toString();

  Future uploadFile() async {
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference refrenceDirImages = referenceRoot
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("basicInfo")
        .child(uniqueNameClass);

    try {
      await refrenceDirImages.putFile(File(file!.path));
      profilePicUrl = await refrenceDirImages.getDownloadURL();

    } catch (e) {

    }
    return profilePicUrl;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // AppBar
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ParamedicRegisterAppbar(
            screenName: "Basic Info",
          )),

      //body
      body: ChangeNotifierProvider<ParamedicRegistration>(
        create: (context) => ParamedicRegistration(),
        child: Consumer<ParamedicRegistration>(
          builder: (context, value, child) {

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _forkey,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.02),
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: screenWidth * 0.95,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Pic

                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: InkWell( //assets/images/extra/profilePic.png
                                  onTap: () {
                                    showBottomModelSheetWidget();
                                  },
                                  child: Center(
                                    child: CircleAvatar(
                                        radius: 78,
                                        child: file == null
                                            ? (value.infoUser != null)?  
                                               CircleAvatar(
                                            radius: 78,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(value.infoUser!.profileImage) ) : 
                                             const CircleAvatar(

                                            radius: 78,
                                            backgroundImage: AssetImage(
                                                "assets/images/extra/profilePic.png"))                                    //     ? (value.infoUser!.profileImage != null)
                                       
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.file(
                                            File(file!.path),
                                            fit: BoxFit.cover,
                                            width: 400,
                                          ),
                                        )),
                                  )
                              ),
                            ),

                            // Add Photo container
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    showBottomModelSheetWidget();
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

                            //Text fields

                            //first name
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15),
                              child: Text(
                                "First Name",
                                style: AppTextStyles.popins(
                                    style: const TextStyle(
                                        color: AppColors.kDarkColor,
                                        fontSize: 16)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 12, top: 0),
                              child: TextFieldClass(
                                fieldController:  fname ,
                                validate: (valid){
                                  if (valid!.isEmpty ||
                                      RegExp(r'^[A-Z]+$').hasMatch(valid)) {
                                    return "required username";
                                  } else {
                                    return null;
                                  }
                                }
                              ),
                            ),

                            // LastName
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 15),
                              child: Text(
                                "Last Name",
                                style: AppTextStyles.popins(
                                    style: const TextStyle(
                                        color: AppColors.kDarkColor,
                                        fontSize: 16)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 12, top: 0),
                              child: TextFieldClass(
                                validate: (valid){
                                  if (valid!.isEmpty ||
                                      RegExp(r'^[A-Z]+$').hasMatch(valid)) {
                                    return "required username";
                                  } else {
                                    return null;
                                  }
                                },
                                fieldController: lname,
                              ),
                            ),

                            // DOB
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 15),
                              child: Text(
                                "Date of birth",
                                style: AppTextStyles.popins(
                                    style: const TextStyle(
                                        color: AppColors.kDarkColor,
                                        fontSize: 16)),
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  width: screenWidth * 0.87,
                                  height: screenHeight * 0.06,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}",
                                          style: AppTextStyles.popins(
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.calendar_month,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //Email Field
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 15),
                              child: Text.rich(TextSpan(children: <TextSpan>[
                                // ignore: prefer_const_constructors
                                TextSpan(
                                    text: 'Email',
                                    style: AppTextStyles.popins(
                                        style: const TextStyle(
                                            color: AppColors.kDarkColor,
                                            fontSize: 16))),
                                // ignore: prefer_const_constructors
                                TextSpan(
                                    text: '   Optional',
                                    style: AppTextStyles.popins(
                                        style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                    ))),
                              ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 12, bottom: 15),
                              child: TextFieldClass(

                                validate: (value ){
                                  if(!EmailValidator.validate(email.text.trim())){
                                    return "invalid email ";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                fieldController: email,
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
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          onPressed: () async {

                            if (_forkey.currentState!.validate()) {
                              LoadingDialogue.showLoaderDialog(context);
                              profilePicUrl = await uploadFile();
                              if (profilePicUrl == null) {
                              if  (value.infoUser?.profileImage == null){
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                newSnackBar(context,"Profile picture required");
                              }
                              else{
                                await value.paramedicBasicInfo(fname.text, lname.text, selectedDate.millisecondsSinceEpoch, value.infoUser!.profileImage, email.text );

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                newSnackBar(context, "data saved");
                              }

                              }
                              else
                              {
                                await value.paramedicBasicInfo(fname.text, lname.text, selectedDate.millisecondsSinceEpoch, profilePicUrl!, email.text );

                           // ignore: use_build_context_synchronously
                           Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                newSnackBar(context, "data saved");
                              }
                            }
                             else{
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
                                text:
                                    'If you have questions, please contact our\n',
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
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  showBottomModelSheetWidget() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.kSecondryColor,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Select source",
                style: AppTextStyles.popins(
                    style: const TextStyle(
                        color: AppColors.kDarkColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            Divider(
              thickness: 0.7,
              color: AppColors.kDarkColor.withOpacity(0.1),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                selectPicCatagory("Camera", Icons.camera_alt_outlined,
                    AppColors.kPrimaryColor, onTap: () {
                  // print("object");
                  pickImageFromCamera()
                      .then((value) => Navigator.of(context).pop());
                }),
                selectPicCatagory("Files", Icons.folder, Colors.blue,
                    onTap: () {
                  pickImageFromGallery()
                      .then((value) => Navigator.of(context).pop());
                }),
                selectPicCatagory(
                    "Gallery", Icons.image_outlined, AppColors.kPrimaryColor,
                    onTap: () {
                  pickImageFromGallery()
                      .then((value) => Navigator.of(context).pop());
                }),
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        );
      },
    );
  }

  Widget selectPicCatagory(String text, IconData icon, Color iconColor,
      {required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kSecondryColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: AppColors.kDarkColor.withOpacity(0.12),
                        spreadRadius: 3)
                  ]),
              height: 45,
              width: 45,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  onTap();
                },
                icon: Icon(icon),
                color: iconColor,
                iconSize: 28,
              ))),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
              style: AppTextStyles.popins(
                  style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 16,
              )),
            ),
          )
        ],
      ),
    );
  }
  void newSnackBar(BuildContext context, String text) {
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
