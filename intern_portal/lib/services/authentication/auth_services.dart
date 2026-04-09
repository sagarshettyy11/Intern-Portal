import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      final token = data['data']['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return {"success": true, "data": data['data']};
    }
    return {"success": false, "message": data['message']};
  }
}
