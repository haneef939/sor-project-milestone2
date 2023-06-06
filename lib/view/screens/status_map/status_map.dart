import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/Models/project_list_model.dart';
import '../../../data/assets_path.dart';

class StatusMapScreen extends StatefulWidget {
  ProjectDetails projectDetails;

  StatusMapScreen({super.key, required this.projectDetails});

  @override
  State<StatusMapScreen> createState() => _StatusMapScreenState();
}

class _StatusMapScreenState extends State<StatusMapScreen> {
  late GoogleMapController _mapController;
  bool isLoading = true;
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.grey,
          title: Text(
            "Status Map",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
        body: _currentPosition == null ||
                _currentPosition?.latitude == null ||
                _currentPosition?.longitude == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          ImagesPath.sorIcon,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Text(
                            "Status Map",
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    if (_currentPosition?.latitude != null &&
                        _currentPosition?.longitude != null)
                      Expanded(
                        // child: Image.asset(
                        //   "assets/icons/png/full_map.png",
                        //   width: MediaQuery.of(context).size.width,
                        //   fit: BoxFit.fill,
                        // ),
                        child: GoogleMap(
                          markers: {
                            Marker(
                              markerId: MarkerId('status_marker'),
                              position: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              infoWindow: InfoWindow(title: 'Current Location'),
                            ),
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                            zoom: 15,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController = controller;
                          },
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
