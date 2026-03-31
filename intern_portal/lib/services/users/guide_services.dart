import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/guide/guide_dashboard_model.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideServices {
  static Future<GuideDashboardModel?> fetchGuideDashboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      debugPrint("TOKEN: $token"); // ✅ DEBUG
      final response = await http.get(
        Uri.parse(ApiEndpoints.guideDashboard),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      debugPrint("STATUS: ${response.statusCode}"); // ✅ DEBUG
      debugPrint("BODY: ${response.body}"); // ✅ DEBUG
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return GuideDashboardModel.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      debugPrint("ERROR: $e"); // ✅ DEBUG
      return null;
    }
  }
}
