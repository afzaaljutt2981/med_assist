import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_text_style.dart';
import '../utils/colors.dart';

class ChoosePicFuntions {
 
  
  showBottomModelSheetWidget(context, Function() pickImageFromCamera, Function() pickImageFromGallery ){
  return  showModalBottomSheet(
                              
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
                                  const SizedBox(height: 10,),
                                    Row(children: [
                                      selectPicCatagory("Camera", Icons.camera_alt_outlined,AppColors.kPrimaryColor, onTap: (){
                                       // print("object");
                                       pickImageFromCamera();
                                      }),
                                      selectPicCatagory("Files", Icons.folder,Colors.blue, onTap: (){
                                       // pickImageFromGallery();
                                      }),
                                       selectPicCatagory("Gallery", Icons.image_outlined, AppColors.kPrimaryColor, onTap: (){
                                        //pickImageFromGallery();
                                       }),
                                      
                                       
                                    ],),
                                  
                                  const SizedBox(height: 100,)
                                  ],
                                );
                              },
                            );
}

 Widget selectPicCatagory(String text, IconData icon, Color iconColor,  {required Function onTap} ){
     return Padding(
       padding: const EdgeInsets.only(left: 20),
       child: Column(
                                          children: [
                                            Container(
                                              decoration:  BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.kSecondryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: AppColors.kDarkColor.withOpacity(0.12),
                                                    spreadRadius: 3
                                                  )
                                                ]
                                              ),
                                              height: 45,
                                              width: 45,
                                              child: Center(child: IconButton(onPressed:(){
                                                onTap();
                                              } , icon:  Icon(icon), color: iconColor, iconSize: 28,))
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text( text,  style: AppTextStyles.popins(
                                                style: const TextStyle(
                                                    color: AppColors.kDarkColor,
                                                    fontSize: 16,
                                                   )),),
                                            )
                                          ],
       ),
     );
  }

}