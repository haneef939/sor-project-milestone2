import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotonresponse/data/Models/project_list_model.dart';

import '../../../data/Models/incident_list_model.dart';
import '../../../data/Navigation/navigation.dart';
import '../../../data/UserApi/user_api.dart';
import '../../../data/assets_path.dart';
import '../home_screen/home_screen.dart';
import 'incident_details.dart';

class IncidentList extends StatefulWidget {
  ProjectDetails projectDetails;
  IncidentList({super.key, required this.projectDetails});

  @override
  State<IncidentList> createState() => _IncidentListState();
}

class _IncidentListState extends State<IncidentList> {
  int selectedIndex = 0;
  bool loading = true;
  IncidentListModel? incidentListModel;
  getIncidentList() {
    Future.delayed(Duration(milliseconds: 500), () async {
      await UserApi.getIncidentList(
              context: context,
              email: FirebaseAuth.instance.currentUser?.email ?? "haneef93907@gmail.com")
          .then((value) {
        if (value != null) {
          setState(() {
            loading = false;
            incidentListModel = value;
          });
        }
      });
    });
  }

  @override
  void initState() {
    getIncidentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          foregroundColor: Colors.grey,
          title: Text(
            "Project ID : ${widget.projectDetails.projectid ?? 0}",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
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
                    height: 10.h,
                  ),
                  Text(
                    "Project ID : ${widget.projectDetails.projectid ?? 0} ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: incidentListModel?.incidents?.isEmpty == true ||
                              incidentListModel == null
                          ? const Center(
                              child: Text("No Incident Found"),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1.h,
                                  color: Colors.black,
                                );
                              },
                              itemCount:
                                  incidentListModel?.incidents?.length ?? 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: ListTile(
                                    tileColor: selectedIndex == index
                                        ? Colors.grey.shade300
                                        : Colors.transparent,
                                    leading: SizedBox(
                                      width: 50.w,
                                      child: Image.network(
                                        incidentListModel
                                                ?.incidents?[index].icon ??
                                            "",
                                        fit: BoxFit.contain,
                                        errorBuilder: (BuildContext context,
                                            Object? exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                              "assets/icons/png/home-mystatus-icon.png");
                                        },
                                      ),
                                    ),
                                    title: Text(
                                      incidentListModel?.incidents?[index].name
                                                  ?.isEmpty ==
                                              true
                                          ? "No Name"
                                          : incidentListModel
                                                  ?.incidents?[index].name ??
                                              "No Name",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          overflow: TextOverflow.ellipsis,
                                          color: selectedIndex == index
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "When : ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: selectedIndex == index
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Expanded(
                                              child: Text(
                                                incidentListModel
                                                        ?.incidents?[index]
                                                        .created ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color:
                                                        selectedIndex == index
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Created By : ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: selectedIndex == index
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Expanded(
                                              child: Text(
                                                incidentListModel
                                                        ?.incidents?[index]
                                                        .createdBy ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color:
                                                        selectedIndex == index
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Distance : ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: selectedIndex == index
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Text(
                                              "${incidentListModel?.incidents?[index].distance ?? ""}KM",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: selectedIndex == index
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        AppNavigator.pushNameRoute(
                                            screen: IncidentDetails(
                                              incident: incidentListModel
                                                      ?.incidents?[index] ??
                                                  Incidents(),
                                            ),
                                            context: context);
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (_) {
                                        //   return IncidentDetails(
                                        //     incident: incidentListModel
                                        //             ?.incidents?[index] ??
                                        //         Incidents(),
                                        //   );
                                        // }));
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.anglesRight,
                                        color: selectedIndex == index
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
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
