import 'package:shared_preferences/shared_preferences.dart';

class AuthHeaders {
  static Future<Map<String, String>> get() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return {"Content-Type": "application/json", "Authorization": "Bearer $token"};
  }
}
