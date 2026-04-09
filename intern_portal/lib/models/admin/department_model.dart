import 'package:flutter/material.dart';

class Department {
  final String name;
  final String code;
  final String hodName;
  final int facultyCount;
  final bool isActive;
  final IconData icon;
  const Department({
    required this.name,
    required this.code,
    required this.hodName,
    required this.facultyCount,
    required this.isActive,
    required this.icon,
  });
}
