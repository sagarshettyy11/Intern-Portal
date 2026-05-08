class AnalyticsResponse {
  final String department;
  final StatsModel stats;
  final int totalStudents;
  final List<StudentModel> students;

  AnalyticsResponse({
    required this.department,
    required this.stats,
    required this.totalStudents,
    required this.students,
  });

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return AnalyticsResponse(
      department: json['department'],
      stats: StatsModel.fromJson(json['stats']),
      totalStudents: json['total_students'],
      students: (json['students'] as List).map((e) => StudentModel.fromJson(e)).toList(),
    );
  }
}

class StatsModel {
  final int totalReports;
  final int approved;
  final int rejected;
  final int pending;

  StatsModel({required this.totalReports, required this.approved, required this.rejected, required this.pending});

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalReports: json['total_reports'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
      pending: json['pending'] ?? 0,
    );
  }
}

class StudentModel {
  final int id;
  final String name;
  final String initials;
  final String usn;
  final String batch;
  final String email;
  final String phone;
  final String? company;
  final String? role;
  final String status;
  final int? total;
  final int? approved;
  final int? pending;
  final bool hasReports;

  const StudentModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.usn,
    required this.batch,
    required this.email,
    required this.phone,
    this.company,
    this.role,
    required this.status,
    this.total,
    this.approved,
    this.pending,
    required this.hasReports,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: int.parse(json['student_id'].toString()),
      name: json['name'],
      initials: _getInitials(json['name']),
      usn: json['reg_no'],
      batch: json['batch'],
      email: json['email'],
      phone: json['phone'],
      company: json['company_name'],
      role: json['role'],
      status: json['status'],
      total: json['total_reports'],
      approved: json['approved'],
      pending: json['pending'],
      hasReports: (json['total_reports'] ?? 0) > 0,
    );
  }

  static String _getInitials(String name) {
    final parts = name.split(" ");
    return parts.length > 1
        ? parts[0][0] + parts[1][0]
        : parts[0][0];
  }
}