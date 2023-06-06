import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spotonresponse/data/Models/project_list_model.dart';
import 'package:spotonresponse/data/Navigation/navigation.dart';
import 'package:spotonresponse/view/screens/authentication/auth_screen.dart';

import '../../../data/assets_path.dart';
import '../../../main.dart';
import '../incident/incident_list.dart';
import '../project_selection/project_selection_screen.dart';
import '../status_map/status_map.dart';

class HomeScreen extends StatefulWidget {
  ProjectDetails projectDetails;
  HomeScreen({super.key, required this.projectDetails});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          foregroundColor: Colors.grey,
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
        key: _scaffoldKey,
        drawer: Drawer(
          width: 250.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  trailing: const FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Close',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  onTap: () {
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                ListTile(
                  trailing: const FaIcon(
                    FontAwesomeIcons.fileCircleCheck,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Change Project ',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  onTap: () {
                    // Handle item 2 tap
                    AppNavigator.pushReplaceUntilNameRoute(
                        screen: ProjectSelectionScreen(), context: context);
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return const ProjectSelectionScreen();
                    // }));
                  },
                ),
                ListTile(
                  trailing: const FaIcon(
                    FontAwesomeIcons.rightFromBracket,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Logout ',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  onTap: () {
                    // Handle item 2 tap
                    prefs?.clear();
                    AppNavigator.pushReplaceUntilNameRoute(
                        screen: AuthScreen(), context: context);
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return const AuthScreen();
                    // }));
                  },
                ),
                // Add more ListTiles for additional items
              ],
            ),
          ),
        ),
        body: Column(children: [
          Image.asset(
            ImagesPath.sorIcon,
            fit: BoxFit.fill,
            width: width,
            height: 60.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Project ID : ${widget.projectDetails.projectid ?? 0} ",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      _openDrawer();
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.gear,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 0;
                // Navigator.push(context, MaterialPageRoute(builder: (_) {
                //   return StatusMapScreen(
                //     projectDetails: widget.projectDetails,
                //   );
                // }));
              });
              AppNavigator.pushNameRoute(
                  screen: StatusMapScreen(
                    projectDetails: widget.projectDetails,
                  ),
                  context: context);
            },
            child: Container(
              height: 80.h,
              color: selectedIndex == 0
                  ? Colors.grey.shade300
                  : Colors.transparent,
              child: Row(
                children: [
                  Image.asset("assets/icons/png/home-statusmap-icon.png"),
                  Text(
                    "Status Map",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 1;
                AppNavigator.pushNameRoute(
                    screen: IncidentList(
                      projectDetails: widget.projectDetails,
                    ),
                    context: context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) {
                //   return IncidentList(
                //     projectDetails: widget.projectDetails,
                //   );
                // }));
              });
            },
            child: Container(
              height: 80.h,
              color: selectedIndex == 1
                  ? Colors.grey.shade400
                  : Colors.transparent,
              child: Row(
                children: [
                  Image.asset("assets/icons/png/home-forms-icon.png"),
                  Text(
                    "Incidents",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
