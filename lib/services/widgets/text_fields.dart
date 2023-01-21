import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_assist/services/utils/app_text_style.dart';
// ignore: must_be_immutable
class TextFieldClass extends StatelessWidget {
  TextEditingController? fieldController;
  bool obsecureText;
  String? hinText; 
  TextInputType? keyboardType;
  String? Function(String?)? validate;
  TextFieldClass({Key? key,this.fieldController, this.obsecureText = false, this.hinText, this.validate, this.keyboardType, }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: TextFormField(
                obscureText: obsecureText,
                validator:validate ,
                
            controller:fieldController,
            style:  GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.6), fontSize: 17),
            decoration: InputDecoration(
              
              contentPadding: const EdgeInsets.only(left: 15),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText:hinText,
              hintStyle:  AppTextStyles.popins(
                style: TextStyle(
                  letterSpacing: -0.41,
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 17,

                )
              ),
              
            
            ),
          ))
        ],
      ); 
  }
}