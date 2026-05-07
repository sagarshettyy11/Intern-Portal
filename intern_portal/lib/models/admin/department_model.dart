import 'package:flutter/material.dart';

class Department {
  final int id;
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
  });
  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: int.tryParse(json['department_id'].toString()) ?? 0,
      name: json['department_name']?.toString() ?? '',
      code: json['dept_code']?.toString() ?? '',
      hodName: json['hod_names']?.toString() ?? '',
      facultyCount: int.tryParse(json['faculty_count']?.toString() ?? '0') ?? 0,
      isActive: json['status']?.toString().toLowerCase() == 'active',
      icon: Icons.school,
    );
  }
}
