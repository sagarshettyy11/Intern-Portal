class DashboardModel {
  final String greeting;
  final DashboardStudent student;
  final InternshipData? internship;
  final ReportStats reports;
  final List<JourneyStep> journey;
  final List<AlertModel> alerts;
  DashboardModel({
    required this.greeting,
    required this.student,
    this.internship,
    required this.reports,
    required this.journey,
    required this.alerts,
  });
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      greeting: json['greeting'] ?? '',
      student: DashboardStudent.fromJson(json['student']),
      internship: json['internship'] != null ? InternshipData.fromJson(json['internship']) : null,
      reports: ReportStats.fromJson(json['reports']),
      journey: (json['journey'] as List).map((e) => JourneyStep.fromJson(e)).toList(),
      alerts: (json['alerts'] ?? []).map<AlertModel>((e) => AlertModel.fromJson(e)).toList(),
    );
  }
}

class DashboardStudent {
  final String name;
  final String regNo;
  final String department;
  DashboardStudent({required this.name, required this.regNo, required this.department});
  factory DashboardStudent.fromJson(Map<String, dynamic> json) {
    return DashboardStudent(
      name: json['name'] ?? '',
      regNo: json['registration_no'] ?? '',
      department: json['department_name'] ?? '',
    );
  }
}

class InternshipData {
  final String company;
  final String status;
  final int completion;
  final int? daysRemaining;
  InternshipData({required this.company, required this.status, required this.completion, this.daysRemaining});
  factory InternshipData.fromJson(Map<String, dynamic> json) {
    return InternshipData(
      company: json['company_name'] ?? '',
      status: json['status'] ?? '',
      completion: json['completion_pct'] ?? 0,
      daysRemaining: json['days_remaining'],
    );
  }
}

class ReportStats {
  final int total;
  final int approved;
  final int pending;
  ReportStats({required this.total, required this.approved, required this.pending});
  factory ReportStats.fromJson(Map<String, dynamic> json) {
    return ReportStats(total: json['total'] ?? 0, approved: json['approved'] ?? 0, pending: json['pending'] ?? 0);
  }
}

class JourneyStep {
  final String label;
  final String status;
  final String? date;
  JourneyStep({required this.label, required this.status, this.date});
  factory JourneyStep.fromJson(Map<String, dynamic> json) {
    return JourneyStep(label: json['label'] ?? '', status: json['status'] ?? '', date: json['date']);
  }
}

class AlertModel {
  final String title;
  final String description;
  final String type;
  final int? reportId;
  final String? deadline;
  final int? daysLeft;
  final String? status;
  AlertModel({
    required this.title,
    required this.description,
    required this.type,
    this.reportId,
    this.deadline,
    this.daysLeft,
    this.status,
  });
  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      reportId: json['report_id'],
      deadline: json['deadline'],
      daysLeft: json['days_left'],
      status: json['status'],
    );
  }
}
