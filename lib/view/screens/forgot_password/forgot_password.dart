import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/assets_path.dart';
import '../../widgets/snack_bar.dart';
import '../authentication/auth_functionality.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    // Email validation regex pattern
    final String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    final RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.grey,
          title:const Text(
            "Forgot Password",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Column(
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
              height: 30.h,
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
                        onTap: () {},
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Material(
                    shadowColor: Colors.black,
                    elevation: 20.0,
                    borderRadius: BorderRadius.circular(12.r),
                    child: TextFormField(
                      cursorColor: Colors.grey,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (_validateEmail(emailController.text)) {
                        AuthFunctionality.resetPassword(
                            context, emailController.text.trim());
                      } else {
                        SnackBarHelper.showSnackBar(
                            context, 'Please enter valid email.');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Text(
                        "Send Email",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
