import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/student_models.dart';
import 'package:intern_portal/services/api_endpoints.dart';

class StudentServices {
  static Future<StudentProfile?> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.profile), headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          return StudentProfile.fromJson(json['data']);
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

  static Future<bool> updateProfile({required String phone, required String address}) async {
    try {
      final response = await http.put(
        Uri.parse(ApiEndpoints.profile),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "address": address}),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          return true;
        } else {
          debugPrint("Update Error: ${json['message']}");
          return false;
        }
      } else {
        debugPrint("HTTP Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }
}
