import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotonresponse/data/Models/project_list_model.dart';
import 'package:spotonresponse/data/UserApi/user_api.dart';
import 'package:spotonresponse/main.dart';

import '../../../data/Navigation/navigation.dart';
import '../../../data/assets_path.dart';
import '../home_screen/home_screen.dart';

class ProjectSelectionScreen extends StatefulWidget {
  const ProjectSelectionScreen({super.key});

  @override
  State<ProjectSelectionScreen> createState() => _ProjectSelectionScreenState();
}

class _ProjectSelectionScreenState extends State<ProjectSelectionScreen> {
  bool loading = true;
  ProjectListModel? projectListModel;
  @override
  void initState() {
    getProjectList();
    super.initState();
  }

  bool isFound = false;
  DocumentSnapshot? currentUserData;
  getProjectList() {
    Future.delayed(Duration(milliseconds: 500), () async {
      await UserApi.fetchProjects(
              email: FirebaseAuth.instance.currentUser?.email ??
                  "haneef93907@gmail.1com",
              context: context)
          .then((value) {
        if (value != null) {
          setState(() {
            loading = false;
            projectListModel = value;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagesPath.sorIcon,
              fit: BoxFit.fill,
              width: width,
              height: 60.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Project Selection",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : projectListModel?.data?.isEmpty == true ||
                            projectListModel == null
                        ? Center(
                            child: Text("No project found "),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Container(
                                  height: 1.h,
                                  color: Colors.black,
                                ),
                              );
                            },
                            itemCount: projectListModel?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      "Project ID : ",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.grey),
                                    ),
                                    Text(
                                      "${projectListModel?.data?[index].projectid ?? 0}",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.black),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "Project Name : ",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.grey),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${projectListModel?.data?[index].name ?? ""}",
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    // prefs?.clear();
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth
                                                .instance.currentUser?.uid ??
                                            "")
                                        .get()
                                        .then((user) {
                                      FirebaseFirestore.instance
                                          .collection("sessions")
                                          .get()
                                          .then((value) {
                                        for (var element in value.docs) {
                                          if (int.parse(element["projectid"]) ==
                                              (int.parse(projectListModel
                                                      ?.data?[index]
                                                      .projectid ??
                                                  "0"))) {
                                            FirebaseFirestore.instance
                                                .collection("sessions")
                                                .doc(element.id)
                                                .update({
                                              "expire":
                                                  user["expireSessionDate"],
                                              "projectid": projectListModel
                                                      ?.data?[index]
                                                      .projectid ??
                                                  "",
                                              "sessionid": user["sessionId"],
                                              "timestamp": DateTime.now(),
                                              "username": user['email']
                                            }).then((value) {
                                              setState(() {
                                                isFound = true;
                                              });
                                              AppNavigator.pushNameRoute(
                                                  screen: HomeScreen(
                                                    projectDetails:
                                                        projectListModel?.data?[
                                                                index] ??
                                                            ProjectDetails(),
                                                  ),
                                                  context: context);
                                            });
                                            log("Come here");
                                            break;
                                          }
                                        }
                                      });
                                      setState(() {
                                        currentUserData = user;
                                      });
                                    });
                                    if (!isFound && currentUserData != null) {
                                      setState(() {
                                        isFound = true;
                                      });
                                      FirebaseFirestore.instance
                                          .collection("sessions")
                                          .doc()
                                          .set({
                                        "expire": currentUserData?[
                                            "expireSessionDate"],
                                        "projectid": projectListModel
                                                ?.data?[index].projectid ??
                                            "",
                                        "sessionid":
                                            currentUserData?["sessionId"],
                                        "timestamp": DateTime.now(),
                                        "username": currentUserData?['email']
                                      }).then((value) {
                                        setState(() {
                                          isFound = false;
                                        });
                                        AppNavigator.pushNameRoute(
                                            screen: HomeScreen(
                                              projectDetails: projectListModel
                                                      ?.data?[index] ??
                                                  ProjectDetails(),
                                            ),
                                            context: context);
                                      });
                                    }

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (_) {
                                    //   return HomeScreen(
                                    //     projectDetails:
                                    //         projectListModel?.data?[index] ??
                                    //             ProjectDetails(),
                                    //   );
                                    // }));
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }))
          ],
        ),
      ),
    );
  }
}
