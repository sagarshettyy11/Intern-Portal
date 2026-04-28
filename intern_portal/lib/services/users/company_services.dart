import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/auth_headers.dart';

class CompanyService {
  static Future<List<Map<String, dynamic>>> fetchCertificates() async {
    final headers = await AuthHeaders.get();
    final res = await http.get(Uri.parse(ApiEndpoints.certificate), headers: headers);
    final json = jsonDecode(res.body);
    if (json['success']) {
      return List<Map<String, dynamic>>.from(json['data']);
    }
    return [];
  }

  static Future<Map<String, dynamic>?> fetchProfile() async {
    final headers = await AuthHeaders.get();
    final res = await http.get(Uri.parse(ApiEndpoints.companyProfile), headers: headers);
    debugPrint("STATUS: ${res.statusCode}");
    debugPrint("BODY:");
    debugPrint(res.body);
    if (!res.body.startsWith('{')) {
      throw Exception("API is not returning JSON:\n${res.body}");
    }
    final json = jsonDecode(res.body);
    if (json['success']) {
      return json['data']['profile'];
    }
    return null;
  }
}
