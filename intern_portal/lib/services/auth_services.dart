import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/services/api_endpoints.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({required String email, required String password}) async {
    try {
      debugPrint("URL: ${ApiEndpoints.loginUrl}");
      final response = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      debugPrint("Response code: ${response.statusCode}");
        debugPrint("Body: ${response.body}");
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['success'] == true) {
        return {"success": true, "data": responseData['data'], "message": responseData['message']};
      }
      return {"success": false, "message": responseData['message'] ?? "Login failed"};
    } catch (e) {
      return {"success": false, "message": "Something went wrong. Please try again.", "error": e.toString()};
    }
  }
}
