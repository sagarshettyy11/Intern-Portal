import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  static Future<List<dynamic>> fetchDepartments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse("${ApiEndpoints.adminDepartment}?action=list"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return json['data']['departments'];
      }
      debugPrint("API ERROR: ${json['message']}");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

  static Future<bool> addDepartment({required String name, required String code, int? hodId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse("${ApiEndpoints.adminDepartment}?action=add"),
        headers: {"Authorization": "Bearer $token"},
        body: {"dept_name": name, "dept_code": code, if (hodId != null) "hod_faculty_id": hodId.toString()},
      );
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return true;
      } else {
        debugPrint("ERROR: ${json['message']}");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
    return false;
  }

  static Future<List<dynamic>> fetchHodList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse("${ApiEndpoints.adminDepartment}?action=hod_list"),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      debugPrint("HOD RESPONSE: ${response.body}");
      if (json['success'] == true) {
        return json['data']['hods'];
      }
    } catch (e) {
      debugPrint("HOD ERROR: $e");
    }

    return [];
  }

  // ======================
  // FACULTY APIs
  // ======================

  static Future<Map<String, dynamic>> fetchFaculty({
    int page = 1,
    String search = '',
    String status = 'all',
    int? deptId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = Uri.parse(
        "${ApiEndpoints.faculty}?action=list"
        "&page=$page"
        "&search=$search"
        "&status=$status"
        "${deptId != null ? "&dept=$deptId" : ""}",
      );

      final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        return json['data'];
      } else {
        debugPrint("FACULTY ERROR: ${json['message']}");
      }
    } catch (e) {
      debugPrint("FACULTY FETCH ERROR: $e");
    }

    return {};
  }

  static Future<bool> addFaculty({
    required String name,
    required String email,
    required String phone,
    required String designation,
    required int departmentId,
    required String role,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse("${ApiEndpoints.faculty}?action=add"),
        headers: {"Authorization": "Bearer $token"},
        body: {
          "faculty_name": name,
          "faculty_email": email,
          "faculty_contact": phone,
          "designation": designation,
          "department_id": departmentId.toString(),
          "role": role,
        },
      );

      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        return true;
      } else {
        debugPrint("ADD FACULTY ERROR: ${json['message']}");
      }
    } catch (e) {
      debugPrint("ADD ERROR: $e");
    }

    return false;
  }

  static Future<bool> editFaculty({
    required int facultyId,
    required String name,
    required String email,
    required String phone,
    required String designation,
    required int departmentId,
    required String role,
    required String status,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse("${ApiEndpoints.faculty}?action=edit"),
        headers: {"Authorization": "Bearer $token"},
        body: {
          "faculty_id": facultyId.toString(),
          "faculty_name": name,
          "faculty_email": email,
          "faculty_contact": phone,
          "designation": designation,
          "department_id": departmentId.toString(),
          "role": role,
          "status": status,
        },
      );

      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        return true;
      } else {
        debugPrint("EDIT ERROR: ${json['message']}");
      }
    } catch (e) {
      debugPrint("EDIT ERROR: $e");
    }

    return false;
  }
}
