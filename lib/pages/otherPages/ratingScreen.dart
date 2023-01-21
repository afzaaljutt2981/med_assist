import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';

import '../../services/models/PatientModels/getParamedicOffers.dart';
import '../../services/utils/app_text_style.dart';
import '../../services/utils/colors.dart';

class RatingParamedicScreen extends StatefulWidget {
  RatingParamedicScreen({Key? key, required this.currentParamedic})
      : super(key: key);
  GetParamedicsOffers currentParamedic;
  @override
  State<RatingParamedicScreen> createState() => _RatingParamedicScreenState();
}

class _RatingParamedicScreenState extends State<RatingParamedicScreen> {
  @override
  double initialValue = 0;
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterPeramedic>(
      create: (context) => RegisterPeramedic(),
      child: Scaffold(
        backgroundColor: AppColors.kSecondryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.kSecondryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                Consumer<RegisterPeramedic>(builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Rate your service",
                    style: AppTextStyles.popins(
                        style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  const SizedBox(
                    height: 150,
                  ),

                  (widget.currentParamedic.image =="")?
                  const CircleAvatar(
                    //  backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: AssetImage(
                          "assets/images/extra/profilePic.png")):
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    backgroundImage:
                        NetworkImage(widget.currentParamedic.image),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.currentParamedic.paramedicName,
                    style: AppTextStyles.popins(
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RatingStars(
                    value: initialValue,
                    onValueChanged: (v) {
                      setState(() {
                        initialValue = v;
                      });
                    },
                    starBuilder: (index, color) {
                      return Icon(
                        Icons.star_sharp,
                        color: color,
                        size: 50,
                      );
                    },
                    starCount: 5,
                    starSize: 50,
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: true,
                    valueLabelVisibility: false,
                    animationDuration: Duration(milliseconds: 1000),
                    starOffColor: Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Container(
                      height: 45,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                (initialValue == 0)
                                    ? Colors.grey.shade300
                                    : AppColors.kPrimaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () async {
                          if (initialValue == 0) {
                            newSnackBar(context);
                          } else {
                            LoadingDialogue.showLoaderDialog(context);
                            await value.paramedicReviews(
                                widget.currentParamedic.id, initialValue);
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const HomeScreen()),
                                (route) => false);
                          }
                        },
                        child: Text(
                          "Submit",
                          style: AppTextStyles.popins(
                              style: const TextStyle(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const HomeScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "Skip",
                          style: AppTextStyles.popins(
                              style: TextStyle(color: Colors.grey.shade500)),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.pink.shade100,
                        size: 20,
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void newSnackBar(BuildContext context) {
    final snackbaar = SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.black.withOpacity(0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: const Text("value is empty"));
    ScaffoldMessenger.of(context).showSnackBar(snackbaar);
  }
}
