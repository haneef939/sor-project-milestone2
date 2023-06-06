import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:spotonresponse/data/Models/project_list_model.dart';
import 'package:spotonresponse/main.dart';
import 'package:spotonresponse/view/screens/incident/incident_list.dart';

import '../../view/widgets/snack_bar.dart';
import '../Models/incident_list_model.dart';

class UserApi {
  static Future<ProjectListModel?> fetchProjects(
      {String? email, required BuildContext context}) async {
    try {
      final response = await http.get(Uri.parse(
          'https://app.spotonresponse.com/services/authservice.php?action=projectlist&email=$email'));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return ProjectListModel.fromJson(responseData);
      } else {
        return null;
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());
      return null;
    }
  }

  static Future<IncidentListModel?> getIncidentList(
      {String? location, String? email, required BuildContext context}) async {
    try {
      var dio = Dio();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // Define the API endpoint URL
      var url = 'https://app.spotonresponse.com/services/incidentService.php';
      var sessionId = prefs?.getString("sessionId");
      var response = await dio.post(url, data: {
        //  "session": email ?? "haneef93907@gmail.com",
        "session": sessionId,
        "loc": "LatLng(lat:${position.latitude}, lng: ${position.longitude})",
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.data);
        return IncidentListModel.fromJson(responseData);
      } else {
        return null;
      }
    } catch (e) {
      SnackBarHelper.showSnackBar(context, e.toString());
      return null;
    }
  }
}
