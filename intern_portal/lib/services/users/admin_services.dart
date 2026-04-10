import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intern_portal/models/admin/department_model.dart';
import 'package:intern_portal/models/admin/internship_model.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  static Future<List<Department>> fetchDepartments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${ApiEndpoints.adminDepartment}?action=list"),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      final list = json['data']?['departments'] as List? ?? [];
      return list.map((e) => Department.fromJson(e)).toList();
    }
    return [];
  }

  static Future<bool> addDepartment({required String name, required String code, int? hodId}) async {
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
    }
    return false;
  }

  static Future<bool> editDepartment({required int id, required String name, required String code, int? hodId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.adminDepartment}?action=edit"),
      headers: {"Authorization": "Bearer $token"},
      body: {
        "dept_id": id.toString(),
        "dept_name": name,
        "dept_code": code,
        if (hodId != null) "hod_faculty_id": hodId.toString(),
      },
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<bool> deleteDepartment(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.adminDepartment}?action=delete"),
      headers: {"Authorization": "Bearer $token"},
      body: {"dept_id": id.toString()},
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<List<dynamic>> fetchHodList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${ApiEndpoints.adminDepartment}?action=hod_list"),
      headers: {"Authorization": "Bearer $token"},
    );
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      return json['data']['hods'];
    }
    return [];
  }

  static Future<Map<String, dynamic>> fetchFaculty({
    int page = 1,
    String search = '',
    String status = 'all',
    int? deptId,
  }) async {
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
    }
    return false;
  }

  static Future<List<Internship>> fetchInternships({
    String search = '',
    String status = 'all',
    String year = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse(
      "${ApiEndpoints.adminInternship}?action=list"
      "&search=$search"
      "&status=$status"
      "&year=$year",
    );
    final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});
    final json = jsonDecode(response.body);
    if (json['success'] == true) {
      final internships = json['data']?['batches'];
      if (internships == null || internships is! List) {
        return [];
      }
      return internships.map<Internship>((e) => Internship.fromJson(e)).toList();
    }

    return [];
  }

  static Future<bool> addInternship({
    required String name,
    required String year,
    required String duration,
    required String mode,
    required List<int> departments,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.adminInternship}?action=add"),
      headers: {"Authorization": "Bearer $token"},
      body: {
        "internship_name": name,
        "year": year,
        "duration": duration,
        "mode": mode,
        "departments": departments.join(','),
      },
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<bool> editInternship({
    required int id,
    required String name,
    required String year,
    required String duration,
    required String mode,
    required String status,
    required List<int> departments,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.adminInternship}?action=edit"),
      headers: {"Authorization": "Bearer $token"},
      body: {
        "internship_master_id": id.toString(),
        "internship_name": name,
        "year": year,
        "duration": duration,
        "mode": mode,
        "status": status,
        "departments": departments.join(','),
      },
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<bool> deleteInternship(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${ApiEndpoints.adminInternship}?action=delete"),
      headers: {"Authorization": "Bearer $token"},
      body: {"internship_master_id": id.toString()},
    );
    final json = jsonDecode(response.body);
    return json['success'] == true;
  }
}
