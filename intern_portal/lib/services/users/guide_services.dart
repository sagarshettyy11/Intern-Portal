import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/guide/guide_certificate_model.dart';
import 'package:intern_portal/models/guide/guide_dashboard_model.dart';
import 'package:intern_portal/models/guide/guide_internship_model.dart';
import 'package:intern_portal/models/guide/guide_notification_model.dart';
import 'package:intern_portal/models/guide/guide_profile_model.dart';
import 'package:intern_portal/models/guide/guide_report_model.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideServices {
  static Future<GuideDashboardModel?> fetchGuideDashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(ApiEndpoints.guideDashboard),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return GuideDashboardModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> fetchGuideRequests({
    String status = "all",
    int page = 1,
    int limit = 10,
    String search = "",
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = "${ApiEndpoints.request}?action=list&status=$status&page=$page&limit=$limit&search=$search";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return json['data'];
    }
    return null;
  }

  static Future<InternshipReviewModel?> fetchRequestDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = "${ApiEndpoints.requestDetails}?action=detail&id=$id";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final body = response.body;

    if (!body.startsWith('{')) {
      debugPrint("❌ API ERROR RESPONSE:");
      debugPrint(body);
      throw Exception("API not returning JSON");
    }

    final json = jsonDecode(body);
    if (json['success'] == true) {
      return InternshipReviewModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<bool> updateRequestStatus({required int id, required String action, String feedback = ""}) async {
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
  }

  static Future<ReportListResponse?> fetchReports({
    String tab = "Daily",
    int page = 1,
    int perPage = 10,
    String search = "",
  }) async {
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
  }

  static Future<ReportDetailsModel?> fetchReportDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = "${ApiEndpoints.reportDetails}?action=detail&id=$id";
    final response = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return ReportDetailsModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<bool> evaluateReport({
    required int reportId,
    required String action,
    required double score,
    String feedback = "",
  }) async {
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
  }

  static Future<GuideProfileModel?> fetchGuideProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(ApiEndpoints.guideProfile),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return GuideProfileModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<GuideCertificateResponse?> fetchCertificates({
    String search = '',
    String status = '',
    int page = 1,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final uri = Uri.parse(ApiEndpoints.studentCertificate).replace(
        queryParameters: {
          if (search.isNotEmpty) 'search': search,
          if (status.isNotEmpty) 'status': status,
          'page': page.toString(),
        },
      );
      final res = await http.get(uri, headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"});
      final body = res.body;
      if (!body.startsWith('{')) {
        debugPrint("❌ CERT API ERROR:");
        debugPrint(body);
        return null;
      }
      final json = jsonDecode(body);
      if (json['success'] == true) {
        return GuideCertificateResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("Guide Cert ERROR: $e");
    }
    return null;
  }

  static Future<NotificationResponse?> fetchNotifications({int page = 1, int perPage = 15}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = "${ApiEndpoints.guideNotifications}?page=$page&per_page=$perPage";
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      );
      final body = response.body;
      if (!body.startsWith('{')) {
        debugPrint("❌ NOTIFICATION API ERROR:");
        debugPrint(body);
        return null;
      }
      final json = jsonDecode(body);
      if (json['success'] == true) {
        return NotificationResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("FETCH NOTIFICATION ERROR: $e");
    }
    return null;
  }

  static Future<bool> markNotificationAsRead(int notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.patch(
        Uri.parse(ApiEndpoints.guideNotifications),
        headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
        body: jsonEncode({"action": "mark_read", "notification_id": notificationId}),
      );
      final json = jsonDecode(response.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("MARK READ ERROR: $e");
    }
    return false;
  }

  static Future<bool> markAllNotificationsRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.patch(
        Uri.parse(ApiEndpoints.guideNotifications),
        headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
        body: jsonEncode({"action": "mark_all_read"}),
      );
      final json = jsonDecode(response.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("MARK ALL READ ERROR: $e");
    }
    return false;
  }

  static Future<bool> sendNotification({required int studentId, required String description}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(ApiEndpoints.guideNotifications),
        headers: {"Authorization": "Bearer $token"},
        body: {"action": "send_notification", "student_id": studentId.toString(), "description": description},
      );
      final json = jsonDecode(response.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("SEND NOTIFICATION ERROR: $e");
    }
    return false;
  }
}
