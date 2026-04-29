import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/hod/dashboard_model.dart';
import 'package:intern_portal/models/hod/faculty_model.dart';
import 'package:intern_portal/models/hod/profile_model.dart';
import 'package:intern_portal/models/hod/student_model.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/auth_headers.dart';

class HodServices {
  static Future<HodProfile?> fetchProfile() async {
    try {
      final headers = await AuthHeaders.get();
      final response = await http.get(Uri.parse(ApiEndpoints.hodProfile), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          return HodProfile.fromJson(json['data']);
        } else {
          debugPrint("API Error: ${json['message']}");
          return null;
        }
      } else {
        debugPrint("HTTP Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return null;
    }
  }

  static Future<DepartmentPerformance?> fetchStudentPerformance() async {
    try {
      final headers = await AuthHeaders.get();
      final res = await http.get(Uri.parse(ApiEndpoints.studentPerformance), headers: headers);
      debugPrint("STATUS: ${res.statusCode}");
      debugPrint("BODY: ${res.body}");
      if (!res.body.startsWith('{')) {
        throw Exception("Invalid response:\n${res.body}");
      }
      final json = jsonDecode(res.body);
      if (json['success'] == true) {
        return DepartmentPerformance.fromJson(json['data']);
      } else {
        debugPrint("API Error: ${json['message']}");
        return null;
      }
    } catch (e) {
      debugPrint("Performance ERROR: $e");
      return null;
    }
  }

  static Future<HodDashboard?> fetchDashboard() async {
    try {
      final headers = await AuthHeaders.get();
      final res = await http.get(Uri.parse(ApiEndpoints.hodDashboard), headers: headers);
      debugPrint("DASHBOARD STATUS: ${res.statusCode}");
      debugPrint("DASHBOARD BODY: ${res.body}");
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        if (json['success'] == true) {
          return HodDashboard.fromJson(json['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint("Dashboard ERROR: $e");
      return null;
    }
  }

  static Future<FacultyPerformance?> fetchFacultyPerformance({String search = '', int page = 1}) async {
    try {
      final headers = await AuthHeaders.get();
      final uri = Uri.parse(
        ApiEndpoints.guidePerformance,
      ).replace(queryParameters: {'search': search, 'page': page.toString()});
      final res = await http.get(uri, headers: headers);
      debugPrint("FACULTY STATUS: ${res.statusCode}");
      debugPrint("FACULTY BODY: ${res.body}");
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        if (json['success'] == true) {
          return FacultyPerformance.fromJson(json);
        }
      }
      return null;
    } catch (e) {
      debugPrint("Faculty ERROR: $e");
      return null;
    }
  }
}
