import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fyp_sketch_to_real/Database/local_database.dart';
import 'package:fyp_sketch_to_real/constants.dart';
import 'package:fyp_sketch_to_real/screens/credentials/loginRelated/loginPage.dart';
import 'package:fyp_sketch_to_real/screens/homepage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    UserLocalData().setNotLoggedIn();
    userUid = UserLocalData().getUserUIDGet();
    email = UserLocalData().getUserEmail();
    userName = UserLocalData().getUserName();

    isAdmin = UserLocalData().getIsAdmin();
    return GetMaterialApp(
      title: 'Forever Alumni',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(color: Color(0xff96B7BF)),
        canvasColor: Colors.transparent,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 160,
        splash: Hero(
            tag: "logo",
            child: Image.asset(
              logo,
              height: 160,
            )),
        animationDuration: Duration(seconds: 1),
        centered: true,
        backgroundColor: Colors.white,
        //Color(0xff387A53),

        nextScreen: userUid != "" ? HomePage() : LoginPage(),
        duration: 1,
        splashTransition: SplashTransition.fadeTransition,
      ),
      // ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();

//     if (firebaseUser != null) {
//       return HomePage();
//     }
//     return SignUpOptions();
//   }
// }
