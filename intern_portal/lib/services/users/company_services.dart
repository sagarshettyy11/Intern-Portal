import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/auth_headers.dart';

class CertificateService {
  static Future<List<Map<String, dynamic>>> fetchCertificates() async {
    final headers = await AuthHeaders.get();
    final res = await http.get(Uri.parse(ApiEndpoints.certificate), headers: headers);
    final json = jsonDecode(res.body);
    if (json['success']) {
      return List<Map<String, dynamic>>.from(json['data']);
    }
    return [];
  }
}
