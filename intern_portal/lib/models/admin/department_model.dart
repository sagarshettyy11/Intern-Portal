import 'package:flutter/material.dart';

class Department {
  final int id;
  final int? hodId;
  final String name;
  final String code;
  final String hodName;
  final int facultyCount;
  final bool isActive;
  final IconData icon;
  const Department({
    required this.id,
    required this.name,
    required this.code,
    required this.hodName,
    required this.facultyCount,
    required this.isActive,
    required this.icon,
    this.hodId,
  });
  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: int.parse(json['department_id'].toString()),
      name: json['department_name'] ?? '',
      code: json['dept_code'] ?? '',
      hodName: json['hod_name'] ?? '',
      facultyCount: int.tryParse(json['faculty_count']?.toString() ?? '0') ?? 0,
      isActive: json['status'] == "Active",
      hodId: json['hod_faculty_id'],
      icon: Icons.school,
    );
  }
}
