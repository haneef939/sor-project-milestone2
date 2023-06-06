import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotonresponse/view/screens/authentication/auth_screen.dart';
import 'package:spotonresponse/view/screens/home_screen/home_screen.dart';
import 'package:spotonresponse/view/screens/project_selection/project_selection_screen.dart';

// Obtain shared preferences.
SharedPreferences? prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    // await FacebookAuth.instance.webAndDesktopInitialize(
    //   appId: "1:846251353817:web:1a0967d9237177b88540c8",
    //   cookie: true,
    //   xfbml: true,
    //   version: "v16.0",
    // );
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCt2y2v4ciO1kULjDlJxMVt0MH84u49UJs",
            authDomain: "sorf-d2b6d.firebaseapp.com",
            projectId: "sorf-d2b6d",
            storageBucket: "sorf-d2b6d.appspot.com",
            messagingSenderId: "994429078702",
            appId: "1:994429078702:web:40fd99f0a82a1ecb6cb13f",
            measurementId: "G-4670L77N71"
            ));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent),
            home: prefs?.getString("auth") == null
                ? const AuthScreen()
                : const ProjectSelectionScreen(),
          );
        });
  }
}
