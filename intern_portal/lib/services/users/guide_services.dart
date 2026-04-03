import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/guide/guide_dashboard_model.dart';
import 'package:intern_portal/models/guide/guide_internship_model.dart';
import 'package:intern_portal/models/guide/guide_report_model.dart';
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

  static Future<InternshipReviewModel?> fetchRequestDetails(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final url = "${ApiEndpoints.requestDetails}?action=detail&id=$id";

      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );

      debugPrint("DETAIL URL: $url");
      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        return InternshipReviewModel.fromJson(json['data']);
      }

      return null;
    } catch (e) {
      debugPrint("ERROR (DETAILS): $e");
      return null;
    }
  }

  static Future<bool> updateRequestStatus({required int id, required String action, String feedback = ""}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final url = "${ApiEndpoints.requestDetails}?action=$action";

      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
        body: {"internship_id": id.toString(), "feedback": feedback},
      );

      final json = jsonDecode(response.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("ERROR (ACTION): $e");
      return false;
    }
  }

  static Future<ReportListResponse?> fetchReports({
    String tab = "Daily",
    int page = 1,
    int perPage = 10,
    String search = "",
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = "${ApiEndpoints.report}?action=list&tab=$tab&page=$page&per_page=$perPage&search=$search";
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      );
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return ReportListResponse.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 🔍 DETAILS
  static Future<ReportDetailsModel?> fetchReportDetails(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = "${ApiEndpoints.reportDetails}?action=detail&id=$id";
      final response = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return ReportDetailsModel.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ✅ APPROVE / REJECT
  static Future<bool> evaluateReport({
    required int reportId,
    required String action, // approve / reject
    required double score,
    String feedback = "",
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = "${ApiEndpoints.reportDetails}?action=evaluate";
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
        body: {"report_id": reportId.toString(), "action": action, "score": score.toString(), "feedback": feedback},
      );
      final json = jsonDecode(response.body);
      return json['success'] == true;
    } catch (e) {
      return false;
    }
  }
  
}
