import 'package:flutter/material.dart';

class CompanyStats {
  final int total;
  final int pending;
  final int approved;
  final int rejected;
  final int guideApproved;
  CompanyStats({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.guideApproved,
  });
  factory CompanyStats.fromJson(Map<String, dynamic> json) {
    return CompanyStats(
      total: _toInt(json['total']),
      pending: _toInt(json['pending']),
      approved: _toInt(json['approved']),
      rejected: _toInt(json['rejected']),
      guideApproved: _toInt(json['guide_approved']),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

enum RequestStatus { pending, verified, approved }

class InternshipRequestModel {
  final int internshipId;
  final String name;
  final String studentId;
  final String department;
  final String college;
  final String role;
  final String startDate;
  final String endDate;
  final String guideStatus;
  final String companyStatus;
  final String appliedOn;

  InternshipRequestModel({
    required this.internshipId,
    required this.name,
    required this.studentId,
    required this.department,
    required this.college,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.guideStatus,
    required this.companyStatus,
    required this.appliedOn,
  });

  factory InternshipRequestModel.fromJson(Map<String, dynamic> json) {
    return InternshipRequestModel(
      internshipId: json['internship_id'],
      name: json['student_name'] ?? '',
      studentId: "ID: ${json['registration_no'] ?? ''}",
      department: json['department_name'],
      college: json['college_name'],
      role: json['job_title'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      guideStatus: json['guide_status'] ?? 'Pending',
      companyStatus: json['company_status'] ?? 'Pending',
      appliedOn: json['created_date'] ?? '',
    );
  }

  RequestStatus get headerStatus {
    switch (companyStatus) {
      case 'Approved':
        return RequestStatus.approved;
      case 'Pending':
        return RequestStatus.pending;
      default:
        return RequestStatus.verified;
    }
  }

  IconData get roleIcon {
    if (role.toLowerCase().contains('data')) {
      return Icons.trending_up_rounded;
    } else if (role.toLowerCase().contains('design')) {
      return Icons.palette_outlined;
    } else {
      return Icons.desktop_windows_outlined;
    }
  }

  Color get guideStatusColor {
    return guideStatus == 'Approved' ? const Color(0xFF1E8A4C) : const Color(0xFF1B3FAB);
  }

  Color get guideStatusBg {
    return guideStatus == 'Approved' ? const Color(0xFFE6F7ED) : const Color(0xFFE8EDFF);
  }

  String get actionType {
    if (companyStatus == 'Pending') return 'approve_reject';
    if (companyStatus == 'Approved') return 'processing';
    return 'review';
  }
}

class InternshipRequestResponse {
  final CompanyStats stats;
  final List<InternshipRequestModel> requests;
  InternshipRequestResponse({required this.stats, required this.requests});
  factory InternshipRequestResponse.fromJson(Map<String, dynamic> json) {
    return InternshipRequestResponse(
      stats: CompanyStats.fromJson(json['stats']),
      requests: (json['requests'] as List).map((e) => InternshipRequestModel.fromJson(e)).toList(),
    );
  }
}
