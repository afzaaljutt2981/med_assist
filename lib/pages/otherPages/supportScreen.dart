import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientDrawerWidget.dart';
import 'package:med_assist/pages/otherPages/widget_support_chat.dart';

import '../../services/models/support_chat_model.dart';
import '../../services/utils/app_text_style.dart';
import '../../services/utils/colors.dart';


class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  
   late DialogFlowtter dialogFlowtter;
   bool loader = false;
  final TextEditingController _controller = TextEditingController();
  var scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];
  
  get w => MediaQuery.of(context).size.width;

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    Future.delayed(const Duration(seconds: 2)).then((value){
           setState(() {
              loader = true;
           });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Calling Drawe
      backgroundColor: (loader == false)? Colors.grey.shade500 : Colors.grey.shade200,
      // AppBar
         appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.kPrimaryColor, )),
        backgroundColor: AppColors.kSecondryColor,
        title: Text("Support", style: AppTextStyles.popins(
          style: const TextStyle(
            color: AppColors.kDarkColor,
            fontSize: 18,
            fontWeight: FontWeight.w600
          )

        ),),
      ),
       body: Container(
        child: Column(
          children: [
            Expanded(child: 
            
            (messages.isEmpty) ? 
              (loader == false)?
              const Center(
                child: SpinKitCircle(
                  duration: Duration(seconds: 2),
                  size: 60,
                  color: AppColors.kPrimaryColor)
              ):
            
            Align(
              alignment: Alignment.topLeft,
              child: emptyText(),
            ):
            
            MessagesScreen(messages: messages,scrollController: scrollController,)),
            (loader == false)? Container():

            Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                  
                 ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child:  TextFormField(
                          
                          controller: _controller,
                          decoration: const InputDecoration(
                            
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                 FloatingActionButton(
                        onPressed: () async {
                        sendMessage(_controller.text);
                        _controller.clear();
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
            )
          ],
        ),
      ),
    );
  }
   sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

Widget emptyText(){
  return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(13),
                    constraints: BoxConstraints(maxWidth: w * 2.3/3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                         bottomRight  : Radius.circular(20),
                        topRight: Radius.circular(20)


                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text("Hello! Thank you for contacting MedAssist! I'm Jane-your digital assistant", style: AppTextStyles.popins(
                        style: const TextStyle(
                          fontSize: 14,
                          wordSpacing: 1.3,
                          fontWeight: FontWeight.w500
                        )
                      ),),
                    ),
                  ),
                  Container(
                   
                    constraints: BoxConstraints(maxWidth: w * 2.3/3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                         bottomRight  : Radius.circular(30),
                        topRight: Radius.circular(30)


                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text("Before I transfor you to an agent, please describe the subject of your question", style: AppTextStyles.popins(
                        style: const TextStyle(
                          fontSize: 14,
                          wordSpacing: 1.3,
                          fontWeight: FontWeight.w500
                        )
                      ),),
                    ),
                  ),
                ],
              );
}
}



