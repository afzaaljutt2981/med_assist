import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import '../../services/utils/app_text_style.dart';
import '../../services/utils/colors.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.email,
  }) : super(key: key);
  String firstname;
  String lastname;
  String email;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstname;
    _laseNameController.text = widget.lastname;
    _emailController.text = widget.email;
  }
  bool? isvalid;
  var dateOfBirth;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _laseNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _textEditingController = TextEditingController();
  String? profilePicUrl;
  XFile? file;
  Future pickImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = image;
    });
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
        .child("profilePics")
        .child(uniqueNameClass);

    try {
      await refrenceDirImages.putFile(File(file!.path));
      profilePicUrl = await refrenceDirImages.getDownloadURL();
      print(profilePicUrl);
    } catch (e) {
      print('error occured');
    }
    return profilePicUrl;
  }

  var formattedDate;
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kSecondryColor,
      // AppBar
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.kPrimaryColor,
              ));
        }),
        backgroundColor: Colors.white,
        title: Text(
          "Profile Settings",
          style: AppTextStyles.popins(
            style: const TextStyle(
                color: AppColors.kDarkColor,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),

      body: ChangeNotifierProvider<RegisterPeramedic>(
        create: (context) => RegisterPeramedic(),
        child: Consumer<RegisterPeramedic>(builder: (context, value, child) {
          // ignore: unrelated_type_equality_checks
          //  (value.user!.dob == "")?selectedDate:
          //   dateOfBirth =DateTime.fromMillisecondsSinceEpoch(value.user!.dob!);
          //   formattedDate = "${dateOfBirth.year}/${dateOfBirth.month}/${dateOfBirth.day}";
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  // Profile Pic
                  Center(
                    child: InkWell(
                      onTap: () {
                        showBottomModelSheetWidget();
                      },
                      child: CircleAvatar(
                          radius: 78,
                          child: file == null
                              ? (value.user != null)
                                  ? (value.user!.image == "")
                                      ? const CircleAvatar(
                                          //  backgroundColor: Colors.white,
                                          radius: 78,
                                          backgroundImage: AssetImage(
                                              "assets/images/extra/profilePic.png"))
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 78,
                                          backgroundImage:
                                              NetworkImage(value.user!.image!))
                                  : Container(
                                      color: Colors.white,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.kPrimaryColor,
                                        ),
                                      ),
                                    )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    File(file!.path),
                                    fit: BoxFit.cover,
                                   width: 400,
                                  ),
                                )),
                    ),
                  ),

                  // Text fields
                  SizedBox(
                    height: screenHeight * 0.035,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: TextFormField(
                      validator: (value){
                        if (value!.isEmpty ||
                            RegExp(r'^[A-Z]+$').hasMatch(value)) {
                          return "required username";
                        } else {
                          return null;
                        }
                      },
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        hintText: "First name (required)",
                        hintStyle: AppTextStyles.popins(
                            style: const TextStyle(
                                color: AppColors.kDarkColor, fontSize: 14)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: TextFormField(
                      validator: (value){
                        if (value!.isEmpty ||
                            RegExp(r'^[A-Z]+$').hasMatch(value)) {
                          return "required username";
                        } else {
                          return null;
                        }
                      },
                      controller: _laseNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        hintText: "Second name (required)",
                        hintStyle: AppTextStyles.popins(
                            style: const TextStyle(
                          color: AppColors.kDarkColor,
                          fontSize: 14,
                        )),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: TextFormField(
                      validator: (_emailController.text != "" ) ? (emailValue){
                        if(!EmailValidator.validate(_emailController.text.trim())){
                          setState(() {
                            print("hello");
                               emailValue = "";
                          });
                          return "invalid  email";
                        }
                        else{
                          return null;
                        }

                      } : null,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        hintText: "email (optional)",
                        hintStyle: AppTextStyles.popins(
                            style: const TextStyle(
                          color: AppColors.kDarkColor,
                          fontSize: 14,
                        )),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  // DOB Text Field
                  Center(
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                //   (value.user!.dob == "")?
                                "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}", //:formattedDate,
                                style: AppTextStyles.popins(
                                    style: const TextStyle(fontSize: 16)),
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

                  // Save Button
                  SizedBox(
                    height: screenHeight * 0.24,
                  ),
                  Container(
                      height: screenHeight * 0.065,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () async {
                          LoadingDialogue.showLoaderDialog(context);
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            profilePicUrl = await uploadFile();
                           await value.updateUserData(
                                firstName: _firstNameController.text,
                                lName: _laseNameController.text,
                                email: _emailController.text,
                                image: (profilePicUrl == null)
                                    ? value.user!.image!
                                    : profilePicUrl,
                                dob: selectedDate);
                            newSnackBar(context,"Info saved" );
                          }

                          Navigator.pop(context);

                        },
                        child: Text(
                          "Save ",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void newSnackBar(BuildContext context,String text ) {
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

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

}

