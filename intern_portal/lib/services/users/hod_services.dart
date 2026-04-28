import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/hod/profile_model.dart';
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
}
