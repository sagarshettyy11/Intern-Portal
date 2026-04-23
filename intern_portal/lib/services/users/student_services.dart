import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/student/certificate_models.dart';
import 'package:intern_portal/models/student/dashboard_models.dart';
import 'package:intern_portal/models/student/internship_models.dart';
import 'package:intern_portal/models/student/notification_models.dart';
import 'package:intern_portal/models/student/student_models.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/authentication/auth_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentServices {
  static Future<DashboardModel?> fetchDashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(ApiEndpoints.dashboard),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      return DashboardModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<Map<String, dynamic>> submitForm({
    required String formAction,
    required String companyName,
    required String category,
    required String industry,
    required String mode,
    required String domain,
    required String jobtitle,
    required String phone,
    required String address,
    required String description,
    required String fromDate,
    required String toDate,
    required String guideName,
    required String guideEmail,
    required String guidePhone,
    required PlatformFile? file,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.registeration));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['form_action'] = formAction;
    request.fields['company_name'] = companyName;
    request.fields['company_category'] = category;
    request.fields['company_industry'] = industry;
    request.fields['job_title'] = jobtitle;
    request.fields['work_mode'] = mode;
    request.fields['company_phone'] = phone;
    request.fields['company_address'] = address;
    request.fields['company_desc'] = description;
    request.fields['internship_domain'] = domain;
    request.fields['start_date'] = fromDate;
    request.fields['end_date'] = toDate;
    request.fields['guide_name'] = guideName;
    request.fields['guide_email'] = guideEmail;
    request.fields['guide_phone'] = guidePhone;
    if (file != null && file.path != null) {
      request.files.add(await http.MultipartFile.fromPath('offer_letter', file.path!));
    }
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    final json = jsonDecode(responseData);
    return json;
  }

  static Future<InternshipModel?> fetchInternship() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(ApiEndpoints.internship),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      return InternshipModel.fromJson(json['data']);
    }
    return null;
  }

  static Future<Map<String, dynamic>> submitReport({
    required String reportType,
    required String periodStart,
    required String periodEnd,
    required String description,
    required String learningOutcomes,
    required String challenges,
    PlatformFile? file,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.reports));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll({
      "report_type": reportType,
      "period_start": periodStart,
      "period_end": periodEnd,
      "activity_description": description,
      "learning_outcomes": learningOutcomes,
      "challenges": challenges,
    });
    if (file != null && file.path != null) {
      request.files.add(await http.MultipartFile.fromPath('attachment', file.path!));
    }
    var response = await request.send();
    var resBody = await response.stream.bytesToString();
    return jsonDecode(resBody);
  }

  static Future<Map<String, dynamic>> fetchReports({
    String? status,
    String? type,
    String sort = "newest",
    int page = 1,
    int perPage = 10,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final queryParams = {"page": page.toString(), "per_page": perPage.toString(), "sort": sort};
    if (status != null && status.isNotEmpty) {
      queryParams["status"] = status;
    }
    if (type != null && type.isNotEmpty) {
      queryParams["type"] = type;
    }
    final uri = Uri.parse(ApiEndpoints.overview).replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      return json['data'];
    }
    return {"success": false};
  }

  static Future<Map<String, dynamic>?> fetchReportById(int reportId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse(ApiEndpoints.overview).replace(queryParameters: {"report_id": reportId.toString()});
    final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return json['data']['report'];
    }
    return null;
  }

  static Future<StudentProfile?> fetchProfile() async {
    final token = await AuthStorage.getToken();
    final response = await http.get(
      Uri.parse(ApiEndpoints.profile),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      return StudentProfile.fromJson(json['data']);
    }
    return null;
  }

  static Future<Map<String, dynamic>> fetchNotifications({int page = 1, int perPage = 15}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse(
      ApiEndpoints.notifications,
    ).replace(queryParameters: {"action": "list", "page": page.toString(), "per_page": perPage.toString()});
    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      return {
        "notifications": (json['data']['notifications'] as List).map((e) => NotificationModel.fromJson(e)).toList(),
        "unread": json['data']['unread_count'],
        "total": json['data']['total'],
      };
    }
    throw Exception("Failed to load notifications");
  }

  static Future<bool> markAllNotificationsRead() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.notifications}?action=mark_all"),
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<Map<String, dynamic>> fetchCertificates() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http.get(
      Uri.parse("${ApiEndpoints.myCertificate}?action=list"),
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
    );
    final json = jsonDecode(res.body);
    if (res.statusCode == 200 && json['success'] == true) {
      return {
        "stats": json['data']['stats'],
        "issued": (json['data']['issued'] as List).map((e) => CertificateModel.fromJson(e)).toList(),
      };
    }
    throw Exception("Failed to load certificates");
  }
}
