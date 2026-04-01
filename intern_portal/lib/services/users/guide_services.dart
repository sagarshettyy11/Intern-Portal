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

  static Future<Map<String, dynamic>?> fetchGuideRequests({
    String status = "all",
    int page = 1,
    int limit = 10,
    String search = "",
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = "${ApiEndpoints.request}?action=list&status=$status&page=$page&limit=$limit&search=$search";
      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      debugPrint("REQUEST URL: $url");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return json['data']; // contains stats + requests
      }
      return null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }
}
