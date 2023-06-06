import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotonresponse/data/Navigation/navigation.dart';
import 'package:spotonresponse/main.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../widgets/snack_bar.dart';
import '../project_selection/project_selection_screen.dart';
import 'auth_screen.dart';

class AuthFunctionality {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "994429078702-p3t6mum6se9vv9psccnhi76r9l5j90fv.apps.googleusercontent.com");

  static Future<UserCredential?> registerUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registration successful, you can perform additional tasks or navigate to a new screen.
      prefs?.setString("auth", userCredential.user?.uid ?? "");
      SnackBarHelper.showSnackBar(
          context, 'Registration successful: ${userCredential.user!.uid}');
      print('Registration successful: ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarHelper.showSnackBar(
            context, 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        SnackBarHelper.showSnackBar(
            context, 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
      // Handle other FirebaseAuthException errors.
      SnackBarHelper.showSnackBar(context, e.toString());
      return null;
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());
      return null;
    }
  }

  static Future<User?> signInWithGoogle1(
      {required BuildContext context}) async {
    // Initialize Firebase
    User? user;

    // The `GoogleAuthProvider` can only be used while running on the web

    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
      if (user != null) {
        prefs?.setString("auth", user.uid);
        AppNavigator.pushReplaceUntilNameRoute(
            screen: ProjectSelectionScreen(), context: context);
      }
      return user;
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());

      return null;
    }
  }
  //
  // static Future<User?> signInWithFacebook1(
  //     {required BuildContext context}) async {
  //   // Initialize Firebase
  //   User? user;
  //
  //   // The `GoogleAuthProvider` can only be used while running on the web
  //
  //   FacebookAuthProvider authProvider = FacebookAuthProvider();
  //
  //   try {
  //     final UserCredential userCredential =
  //         await _auth.signInWithPopup(authProvider);
  //     user = userCredential.user;
  //     if (user != null) {
  //       prefs?.setString("auth", user.uid);
  //       if (userCredential.additionalUserInfo?.isNewUser == true) {
  //         user.getIdToken().then((value1) {
  //           user?.getIdTokenResult().then((value2) {
  //             prefs?.setString("sessionId", value1);
  //             FirebaseFirestore.instance
  //                 .collection("users")
  //                 .doc(user?.uid ?? "")
  //                 .set({
  //               "sessionId": value1,
  //               "createdSessionDate": DateTime.now(),
  //               "expireSessionDate": value2.expirationTime,
  //               "uid": user?.uid ?? "",
  //               "name": user?.displayName ?? "",
  //               "email": user?.email ?? "",
  //             }).whenComplete(() {
  //               AppNavigator.pushReplaceUntilNameRoute(
  //                   screen: ProjectSelectionScreen(), context: context);
  //               // Navigator.push(context, MaterialPageRoute(builder: (_) {
  //               //   return const ProjectSelectionScreen();
  //               // }));
  //             });
  //           });
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     SnackBarHelper.showSnackBar(context, e.toString());
  //   }
  //   return user;
  // }

  static Future<UserCredential?> signInWithGoogle(
      {required BuildContext context}) async {
    try {
      // Trigger the Google Sign-In flow.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request.
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential.
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase with the Google credential.
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      prefs?.setString("auth", userCredential.user?.uid ?? "");
      return userCredential;
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      SnackBarHelper.showSnackBar(context, e.toString());
      return null;
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User signed out");
  }

  static Future<UserCredential?> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppNavigator.pushReplaceUntilNameRoute(
          screen: ProjectSelectionScreen(), context: context);
      prefs?.setString("auth", userCredential.user?.uid ?? "");
      // ignore: use_build_context_synchronously
      SnackBarHelper.showSnackBar(
          context, 'Login successful: ${userCredential.user!.uid}');
      print('Login successful: ${userCredential.user!.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarHelper.showSnackBar(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SnackBarHelper.showSnackBar(
            context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
      // Handle other FirebaseAuthException errors.
      print(e.message);
      SnackBarHelper.showSnackBar(context, e.message.toString());
      return null;
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());
      print(e.toString());
      return null;
    }
  }

  static resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully, inform the user.
      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return AuthScreen();
      // }));
      AppNavigator.pushNameRoute(screen: AuthScreen(), context: context);
      SnackBarHelper.showSnackBar(
          context, 'Password reset email sent to $email');
      print('Password reset email sent to $email');
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());
      // Handle errors during password reset.
    }
  }

  // Perform Facebook login
  // static Future<void> signInWithFacebook(BuildContext context) async {
  //   try {
  //     final result = await FacebookAuth.instance
  //         .login(permissions: ["email", "public_profile"]);
  //
  //     // Check if the login was successful
  //     if (result.status == LoginStatus.success) {
  //       // Retrieve the access token
  //       final accessToken = result.accessToken?.token;
  //
  //       // Authenticate the user with Firebase
  //       final AuthCredential credential =
  //           FacebookAuthProvider.credential(accessToken ?? "");
  //
  //       // Sign in with Firebase using the credential
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //       // Check if the user is new or existing
  //       final User? user = userCredential.user;
  //       final bool isUserNew =
  //           userCredential.additionalUserInfo?.isNewUser ?? false;
  //
  //       // Perform further actions based on whether the user is new or existing
  //       if (isUserNew) {
  //         userCredential.user?.getIdToken().then((value1) {
  //           userCredential.user?.getIdTokenResult().then((value2) {
  //             prefs?.setString("sessionId", value1);
  //             FirebaseFirestore.instance
  //                 .collection("users")
  //                 .doc(userCredential.user?.uid ?? "")
  //                 .set({
  //               "sessionId": value1,
  //               "createdSessionDate": DateTime.now(),
  //               "expireSessionDate": value2.expirationTime,
  //               "uid": userCredential.user?.uid ?? "",
  //               "name": userCredential.user?.displayName ?? "",
  //               "email": userCredential.user?.email ?? "",
  //             }).whenComplete(() {
  //               AppNavigator.pushReplaceUntilNameRoute(
  //                   screen: ProjectSelectionScreen(), context: context);
  //               // Navigator.push(context, MaterialPageRoute(builder: (_) {
  //               //   return const ProjectSelectionScreen();
  //               // }));
  //             });
  //           });
  //         });
  //
  //         // ...
  //       }
  //     }
  //   } catch (e) {
  //     print('Error signing in with Facebook: $e');
  //   }
  // }
}
