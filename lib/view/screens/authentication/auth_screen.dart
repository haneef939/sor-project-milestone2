import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer' as developer;
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotonresponse/data/assets_path.dart';
import 'package:spotonresponse/view/screens/authentication/auth_functionality.dart';
import 'package:spotonresponse/view/screens/project_selection/project_selection_screen.dart';

import '../../../data/Navigation/navigation.dart';
import '../../../main.dart';
import '../../widgets/snack_bar.dart';
import '../forgot_password/forgot_password.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isPassowordVisible = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImagesPath.sorIcon,
                    fit: BoxFit.fill,
                    width: width,
                    height: 60.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = true;
                                });
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: isLogin ? Colors.black : Colors.grey,
                                  fontSize: isLogin ? 30.sp : 28.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: isLogin ? Colors.grey : Colors.black,
                                  fontSize: isLogin ? 28.sp : 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Use the form bellow to access your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        isLogin
                            ? SizedBox.shrink()
                            : SizedBox(
                                height: 20.h,
                              ),
                        isLogin
                            ? SizedBox.shrink()
                            : Material(
                                shadowColor: Colors.black,
                                elevation: 20.0,
                                borderRadius: BorderRadius.circular(12.r),
                                child: TextFormField(
                                  cursorColor: Colors.grey,
                                  controller: nameController,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.w, 12.h, 20.w, 12.h),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.w),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.w),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.w),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Material(
                          shadowColor: Colors.black,
                          elevation: 20.0,
                          borderRadius: BorderRadius.circular(12.r),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            controller: emailController,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email ",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Material(
                          shadowColor: Colors.black,
                          elevation: 20.0,
                          borderRadius: BorderRadius.circular(12.r),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            obscureText: !isPassowordVisible,
                            controller: passwordController,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: "Password",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isPassowordVisible = !isPassowordVisible;
                                  });
                                },
                                child: Icon(
                                  isPassowordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isLogin) {
                                  AppNavigator.pushNameRoute(
                                      screen: ForgotPasswordScreen(),
                                      context: context);
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (_) {
                                  //   return ForgotPasswordScreen();
                                  // }));
                                } else {
                                  AppNavigator.pushNameRoute(
                                      screen: AuthScreen(), context: context);
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (_) {
                                  //   return AuthScreen();
                                  // }));
                                }
                              },
                              child: Text(
                                isLogin
                                    ? "Forgot Password?"
                                    : "Remember Password?",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  if (isLogin && nameController.text.isEmpty) {
                                    await AuthFunctionality.loginUser(
                                            context,
                                            emailController.text.trim(),
                                            passwordController.text.trim())
                                        .then((value) {
                                      if (value != null) {
                                        value.user?.getIdToken().then((value1) {
                                          value.user
                                              ?.getIdTokenResult()
                                              .then((value2) {
                                            prefs?.setString(
                                                "sessionId", value1);
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(value.user?.uid ?? "")
                                                .update({
                                              "sessionId": value1,
                                              "createdSessionDate":
                                                  DateTime.now(),
                                              "expireSessionDate":
                                                  value2.expirationTime,
                                              "uid": value.user?.uid ?? "",
                                            }).then((value) {
                                              isLoading = false;
                                              setState(() {});
                                            });
                                          });
                                        });
                                      }
                                    });
                                  } else {
                                    await AuthFunctionality.registerUser(
                                            context,
                                            emailController.text.trim(),
                                            passwordController.text.trim())
                                        .then((value) {
                                      if (value != null) {
                                        value.user?.getIdToken().then((value1) {
                                          value.user
                                              ?.getIdTokenResult()
                                              .then((value2) {
                                            prefs?.setString(
                                                "sessionId", value1);
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(value.user?.uid ?? "")
                                                .set({
                                              "sessionId": value1,
                                              "createdSessionDate":
                                                  DateTime.now(),
                                              "expireSessionDate":
                                                  value2.expirationTime,
                                              "uid": value.user?.uid ?? "",
                                              "name": nameController.text,
                                              "email":
                                                  emailController.text.trim(),
                                            }).whenComplete(() {
                                              isLoading = false;
                                              AppNavigator
                                                  .pushReplaceUntilNameRoute(
                                                      screen:
                                                          ProjectSelectionScreen(),
                                                      context: context);
                                              // Navigator.push(context,
                                              //     MaterialPageRoute(builder: (_) {
                                              //   return const ProjectSelectionScreen();
                                              // }));
                                            });
                                          });
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                    setState(() {});
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  SnackBarHelper.showSnackBar(
                                      context, "Please enter valid data ");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isLogin ? 40.w : 25.w,
                                    vertical: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: isLoading
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                        ))
                                    : Text(
                                        isLogin ? "Login" : "Register",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (kIsWeb) {
                                  await AuthFunctionality.signInWithGoogle1(
                                          context: context)
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        value.getIdToken().then((value1) {
                                          value
                                              .getIdTokenResult()
                                              .then((value2) {
                                            prefs?.setString(
                                                "sessionId", value1);
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(value.uid)
                                                .set({
                                              "sessionId": value1,
                                              "createdSessionDate":
                                                  DateTime.now(),
                                              "expireSessionDate":
                                                  value2.expirationTime,
                                              "uid": value.uid,
                                              "name": value.displayName ?? "",
                                              "email": value.email ?? "",
                                            }).whenComplete(() {
                                              isLoading = false;
                                              AppNavigator
                                                  .pushReplaceUntilNameRoute(
                                                      screen:
                                                          ProjectSelectionScreen(),
                                                      context: context);
                                              // Navigator.push(context,
                                              //     MaterialPageRoute(builder: (_) {
                                              //   return const ProjectSelectionScreen();
                                              // }));
                                            }).catchError((e) {
                                              print("google error");

                                              print(e.toString());
                                            });
                                          });
                                        });
                                      } catch (e) {
                                        print("google error");
                                        print(e.toString());
                                      }
                                    }
                                  });
                                  setState(() {});
                                } else {
                                  await AuthFunctionality.signInWithGoogle(
                                          context: context)
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        value.user?.getIdToken().then((value1) {
                                              value.user
                                                  ?.getIdTokenResult()
                                                  .then((value2) {
                                                if (value.additionalUserInfo
                                                        ?.isNewUser ==
                                                    true) {
                                                  prefs?.setString(
                                                      "sessionId", value1);
                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(
                                                          value.user?.uid ?? "")
                                                      .set({
                                                    "sessionId": value1,
                                                    "createdSessionDate":
                                                        DateTime.now(),
                                                    "expireSessionDate":
                                                        value2.expirationTime,
                                                    "uid":
                                                        value.user?.uid ?? "",
                                                    "name": value.user
                                                            ?.displayName ??
                                                        "",
                                                    "email":
                                                        value.user?.email ?? "",
                                                  }).whenComplete(() {
                                                    isLoading = false;
                                                    AppNavigator
                                                        .pushReplaceUntilNameRoute(
                                                            screen:
                                                                ProjectSelectionScreen(),
                                                            context: context);
                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(builder: (_) {
                                                    //   return const ProjectSelectionScreen();
                                                    // }));
                                                  }).catchError((e) {
                                                    print(e.toString());
                                                  });
                                                } else {
                                                  prefs?.setString(
                                                      "sessionId", value1);
                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(
                                                          value.user?.uid ?? "")
                                                      .set({
                                                    "sessionId": value1,
                                                    "createdSessionDate":
                                                        DateTime.now(),
                                                    "expireSessionDate":
                                                        value2.expirationTime,
                                                    "uid":
                                                        value.user?.uid ?? "",
                                                    "name": value.user
                                                            ?.displayName ??
                                                        "",
                                                    "email":
                                                        value.user?.email ?? "",
                                                  }).whenComplete(() {
                                                    isLoading = false;
                                                    AppNavigator
                                                        .pushReplaceUntilNameRoute(
                                                            screen:
                                                                ProjectSelectionScreen(),
                                                            context: context);
                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(builder: (_) {
                                                    //   return const ProjectSelectionScreen();
                                                    // }));
                                                  }).catchError((e) {
                                                    print(e.toString());
                                                  });
                                                }
                                              });
                                            }) ??
                                            "";
                                      } catch (e) {
                                        developer.log(e.toString());
                                      }
                                    }
                                  });
                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                radius: 24.r,
                                backgroundColor: Colors.white,
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                  size: 26.r,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            // InkWell(
                            //   onTap: () async {
                            //     setState(() {
                            //       isLoading = true;
                            //     });
                            //     if (kIsWeb) {
                            //       await AuthFunctionality.signInWithFacebook1(
                            //               context: context)
                            //           .then((value) {
                            //         isLoading = false;
                            //       });
                            //     } else {
                            //       await AuthFunctionality.signInWithFacebook(
                            //               context)
                            //           .then((value) {
                            //         isLoading = false;
                            //       });
                            //     }
                            //   },
                            //   child: CircleAvatar(
                            //     radius: 24.r,
                            //     backgroundColor: Colors.white,
                            //     child: FaIcon(
                            //       FontAwesomeIcons.facebookF,
                            //       color: Colors.black,
                            //       size: 26.r,
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  bool _validateEmail(String email) {
    // Email validation regex pattern
    final String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    final RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}
