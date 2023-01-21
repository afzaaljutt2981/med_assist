import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_assist/pages/otherPages/PatientScreens/patientHomeScreen.dart';
import 'package:med_assist/pages/otherPages/checkUserCredentials.dart';
import 'package:med_assist/pages/otherPages/selectionScreen.dart';
import 'package:med_assist/pages/otherPages/splashScreen.dart';
import 'package:med_assist/pages/otherPages/user_logedin.dart';
import 'package:med_assist/pages/test.dart';
import 'package:med_assist/services/providers/RegisterUser.dart';
import 'package:med_assist/services/widgets/loadingDialogue.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    WidgetsApp.debugAllowBannerOverride = false;
    return MaterialApp(
        title: 'MED Assist ',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: (FirebaseAuth.instance.currentUser != null)
            ? ChangeNotifierProvider<RegisterPeramedic>(
                create: (context) => RegisterPeramedic(),
                child: Consumer<RegisterPeramedic>(
                  builder: (context, value, child) {
                    return (value.user != null)
                        ? (nameEmpty(value))
                            ? const ReturnToSelectionScreen()
                            : const ReturnToHomeScreen()
                        : Container();
                  },
                ),
              )
            : const MySplashscreen());
  }

  bool nameEmpty(RegisterPeramedic value) =>
      value.user!.fName == "" || value.user!.lName == "";
}
