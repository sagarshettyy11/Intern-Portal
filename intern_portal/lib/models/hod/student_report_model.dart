class StudentReportResponse {
  final StudentDetails student;
  final Stats stats;
  final Internship? internship;
  final List<Report> reports;
  StudentReportResponse({required this.student, required this.stats, required this.internship, required this.reports});
  factory StudentReportResponse.fromJson(Map<String, dynamic> json) {
    return StudentReportResponse(
      student: StudentDetails.fromJson(json['student']),
      stats: Stats.fromJson(json['stats']),
      internship: json['internship'] != null ? Internship.fromJson(json['internship']) : null,
      reports: (json['reports'] as List).map((e) => Report.fromJson(e)).toList(),
    );
  }
}

class StudentDetails {
  final int id;
  final String name;
  final String email;
  final String registrationNo;
  final String batch;
  final String phone;
  final String department;
  StudentDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.registrationNo,
    required this.batch,
    required this.phone,
    required this.department,
  });
  factory StudentDetails.fromJson(Map<String, dynamic> json) {
    return StudentDetails(
      id: int.parse(json['student_id'].toString()),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      registrationNo: json['registration_no'] ?? '',
      batch: json['batch'] ?? '',
      phone: json['phone'] ?? '',
      department: json['department_name'] ?? '',
    );
  }
}

class Stats {
  final int total;
  final int approved;
  final int pending;
  final int rejected;
  Stats({required this.total, required this.approved, required this.pending, required this.rejected});
  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      total: json['total_reports'] ?? 0,
      approved: json['approved_reports'] ?? 0,
      pending: json['pending_reports'] ?? 0,
      rejected: json['rejected_reports'] ?? 0,
    );
  }
}

class Internship {
  final int id;
  final String company;
  final String role;
  final String guide;
  final String startDate;
  final String endDate;
  final String status;
  Internship({
    required this.id,
    required this.company,
    required this.role,
    required this.guide,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'],
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      guide: json['guide'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Report {
  final int id;
  final String title;
  final String description;
  final String date;
  final String status;
  final String? fileUrl;
  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    this.fileUrl,
  });
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['report_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['report_date'] ?? '',
      status: json['status'] ?? 'Pending',
      fileUrl: json['file_url'],
    );
  }
}
