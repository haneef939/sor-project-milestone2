import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/Models/incident_list_model.dart';
import 'map_screen.dart';

class IncidentDetails extends StatefulWidget {
  Incidents incident;

  IncidentDetails({super.key, required this.incident});

  @override
  State<IncidentDetails> createState() => _IncidentDetailsState();
}

class _IncidentDetailsState extends State<IncidentDetails> {
  late GoogleMapController _mapController;
  final yourScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        title: Text(
          widget.incident.name ?? "",
          style: const TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Scrollbar(
        controller: yourScrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 200.h,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Image.asset(
                  //     "assets/icons/png/download.png",
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),

                  if (widget.incident.lat != null &&
                      widget.incident.lon != null)
                    SizedBox(
                      height: 150.h,
                      child: GoogleMap(
                        markers: {
                          Marker(
                            markerId: const MarkerId('customer_marker'),
                            position: LatLng(double.parse(widget.incident.lat!),
                                double.parse(widget.incident.lon!)),
                            infoWindow: InfoWindow(
                                title: widget.incident.name ?? ""),
                          ),
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(widget.incident.lat!),
                              double.parse(widget.incident.lon!)),
                          zoom: 15,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                      ),
                    ),
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Code : ${widget.incident.code ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Type : ${widget.incident.type ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Created : ${widget.incident.created ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Reason : ${widget.incident.reason ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Disposition : ${widget.incident.disposition ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Incident Status : ${widget.incident.incidentStatus ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Created By : ${widget.incident.createdBy ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Created By User : ${widget.incident.createdByUser ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Last Update : ${widget.incident.lastupdated ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Offline Descriptor : ${widget.incident.offlineDescription ?? ""}",
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 16.sp, overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          "isSIOI : ${widget.incident.isSIOI ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Latitude : ${widget.incident.lat ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Langitude : ${widget.incident.lon ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "UUID : ${widget.incident.uUID ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Radius : ${widget.incident.radius ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "State : ${widget.incident.state ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Count : ${widget.incident.count ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Media Count : ${widget.incident.mediaCount ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Project ID : ${widget.incident.projectID ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          "Incident Project Id : ${widget.incident.incidentProjID ?? ""}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ))
                ]),
          ),
        ),
      ),
    ));
  }
}
