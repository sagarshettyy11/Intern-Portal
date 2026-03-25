import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/dashboard_models.dart';
import 'package:intern_portal/models/internship_models.dart';
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

  static Future<Map<String, dynamic>> submitForm({
    required String formAction,
    required String companyName,
    required String category,
    required String industry,
    required String domain,
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
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoints.registeration));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['form_action'] = formAction;
      request.fields['company_name'] = companyName;
      request.fields['company_category'] = category;
      request.fields['company_industry'] = industry;
      request.fields['company_industry'] = industry;
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
      debugPrint("REGISTER RESPONSE: $responseData");
      final json = jsonDecode(responseData);
      return json;
    } catch (e) {
      debugPrint("REGISTER ERROR: $e");
      return {"success": false, "message": "Something went wrong"};
    }
  }

  static Future<InternshipModel?> fetchInternship() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(ApiEndpoints.internship),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      debugPrint("INTERNSHIP BODY: ${response.body}");
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['success'] == true) {
        return InternshipModel.fromJson(json['data']);
      }
      return null;
    } catch (e) {
      debugPrint("INTERNSHIP ERROR: $e");
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
