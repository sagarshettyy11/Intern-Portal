import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/company/certificate_model.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/auth_headers.dart';

class CompanyService {
  static Future<CertificateResponse?> fetchCertificates() async {
    try {
      final headers = await AuthHeaders.get();
      final res = await http.get(Uri.parse("${ApiEndpoints.certificate}?action=list"), headers: headers);
      debugPrint("CERT STATUS: ${res.statusCode}");
      debugPrint("CERT BODY: ${res.body}");
      if (!res.body.startsWith('{')) {
        debugPrint("Invalid API response:\n${res.body}");
        return null;
      }
      final json = jsonDecode(res.body);
      if (json['success'] == true) {
        return CertificateResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("Certificate ERROR: $e");
    }

    return null;
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
