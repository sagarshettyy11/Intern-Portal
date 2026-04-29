import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/company/attendance_model.dart';
import 'package:intern_portal/models/company/certificate_model.dart';
import 'package:intern_portal/models/company/internship_req_model.dart';
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

  static Future<InternshipRequestResponse?> fetchInternshipRequests({String search = '', String status = ''}) async {
    try {
      final headers = await AuthHeaders.get();
      final uri = Uri.parse(ApiEndpoints.internshipReq).replace(
        queryParameters: {
          'action': 'list',
          if (search.isNotEmpty) 'search': search,
          if (status.isNotEmpty) 'company_status': status,
        },
      );
      final res = await http.get(uri, headers: headers);
      debugPrint("REQ STATUS: ${res.statusCode}");
      debugPrint("REQ BODY: ${res.body}");
      if (!res.body.startsWith('{')) return null;
      final json = jsonDecode(res.body);
      if (json['success'] == true) {
        return InternshipRequestResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("Request ERROR: $e");
    }
    return null;
  }

  static Future<bool> updateInternshipStatus({required int internshipId, required String status}) async {
    try {
      final headers = await AuthHeaders.get();

      final res = await http.post(
        Uri.parse("${ApiEndpoints.internshipReq}?action=update_status"),
        headers: headers,
        body: jsonEncode({
          "internship_id": internshipId,
          "company_status": status, 
        }),
      );
      final json = jsonDecode(res.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("Update ERROR: $e");
      return false;
    }
  }

  static Future<AttendanceResponse?> fetchAttendance({
    String search = '',
    String batch = '',
    int college = 0,
    int branch = 0,
  }) async {
    try {
      final headers = await AuthHeaders.get();
      final res = await http.post(
        Uri.parse(ApiEndpoints.attendance),
        headers: headers,
        body: jsonEncode({
          if (search.isNotEmpty) 'search': search,
          if (batch.isNotEmpty) 'batch': batch,
          if (college != 0) 'college': college,
          if (branch != 0) 'branch': branch,
        }),
      );
      if (!res.body.startsWith('{')) return null;
      final json = jsonDecode(res.body);
      if (json['success'] == true) {
        return AttendanceResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("Attendance ERROR: $e");
    }
    return null;
  }

  static Future<AttendanceDetailResponse?> fetchStudentAttendance(int internshipId) async {
    try {
      final headers = await AuthHeaders.get();
      final uri = Uri.parse(
        ApiEndpoints.addAttendance,
      ).replace(queryParameters: {'internship_id': internshipId.toString()});
      final res = await http.get(uri, headers: headers);
      if (!res.body.startsWith('{')) return null;
      final json = jsonDecode(res.body);
      if (json['success'] == true) {
        return AttendanceDetailResponse.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint("Fetch Attendance ERROR: $e");
    }
    return null;
  }

  static Future<bool> markAttendance({
    required int internshipId,
    required String date,
    required String status,
    String remarks = '',
  }) async {
    try {
      final headers = await AuthHeaders.get();
      final res = await http.post(
        Uri.parse(ApiEndpoints.addAttendance),
        headers: headers,
        body: jsonEncode({
          "internship_id": internshipId,
          "attendance_date": date,
          "attendance_status": status,
          "remarks": remarks,
        }),
      );
      final json = jsonDecode(res.body);
      return json['success'] == true;
    } catch (e) {
      debugPrint("Mark Attendance ERROR: $e");
      return false;
    }
  }
}
