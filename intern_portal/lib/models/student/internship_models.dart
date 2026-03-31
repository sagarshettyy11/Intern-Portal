class InternshipModel {
  final InternshipInfo internship;
  final ReportStats reports;
  final Progress progress;
  final List<Milestone> milestones;
  final List<Mentor> mentors;
  InternshipModel({
    required this.internship,
    required this.reports,
    required this.progress,
    required this.milestones,
    required this.mentors,
  });
  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      internship: InternshipInfo.fromJson(json['internship']),
      reports: ReportStats.fromJson(json['reports']),
      progress: Progress.fromJson(json['progress']),
      milestones: (json['milestones'] ?? []).map<Milestone>((e) => Milestone.fromJson(e)).toList(),
      mentors: (json['mentors'] ?? []).map<Mentor>((e) => Mentor.fromJson(e)).toList(),
    );
  }
}

class InternshipInfo {
  final String? company;
  final String status;
  final String? jobTitle;
  final String? startDate;
  final String? endDate;
  InternshipInfo({this.company, this.jobTitle, required this.status, this.startDate, this.endDate});
  factory InternshipInfo.fromJson(Map<String, dynamic> json) {
    return InternshipInfo(
      jobTitle: json['job_title'],
      company: json['company_name'],
      status: json['status'] ?? '',
      startDate: json['start_date'] == "0000-00-00" ? null : json['start_date'],
      endDate: json['end_date'] == "0000-00-00" ? null : json['end_date'],
    );
  }
}

class ReportStats {
  final int total;
  final int approved;
  final int pending;
  ReportStats({required this.total, required this.approved, required this.pending});
  factory ReportStats.fromJson(Map<String, dynamic> json) {
    return ReportStats(
      total: int.tryParse(json['total'].toString()) ?? 0,
      approved: int.tryParse(json['approved'].toString()) ?? 0,
      pending: int.tryParse(json['pending'].toString()) ?? 0,
    );
  }
}

class Progress {
  final int completion;
  final int? daysRemaining;
  final String grade;
  Progress({required this.completion, this.daysRemaining, required this.grade});
  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      completion: int.tryParse(json['completion_percentage'].toString()) ?? 0,
      daysRemaining: json['days_remaining'] != null ? int.tryParse(json['days_remaining'].toString()) : null,
      grade: json['grade'] ?? '',
    );
  }
}

class Milestone {
  final String title;
  final String status;
  final String? date;
  Milestone({required this.title, required this.status, this.date});
  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(title: json['title'] ?? '', status: json['status'] ?? '', date: json['date']);
  }
}

class Mentor {
  final String name;
  final String role;
  final String? email;
  Mentor({required this.name, required this.role, this.email});
  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(name: json['name'] ?? '', role: json['role'] ?? '', email: json['email']);
  }
}
