import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/dashboard_models.dart';
import 'package:intern_portal/models/student_models.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/authentication/auth_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentServices {
  static Future<DashboardModel?> fetchDashboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(ApiEndpoints.dashboard),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      debugPrint("DASHBOARD BODY: ${response.body}");
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['success'] == true) {
        return DashboardModel.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      debugPrint("DASHBOARD ERROR: $e");
      return null;
    }
  }

  static Future<StudentProfile?> fetchProfile() async {
    try {
      final token = await AuthStorage.getToken();
      final response = await http.get(
        Uri.parse(ApiEndpoints.profile),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      debugPrint("PROFILE BODY:");
      debugPrint(response.body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['success'] == true) {
        return StudentProfile.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
