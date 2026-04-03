class ReportStats {
  final int pending;
  final int approved;
  final int rejected;
  final double avgScore;
  final int unreadNotifications;

  ReportStats({
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.avgScore,
    required this.unreadNotifications,
  });

  factory ReportStats.fromJson(Map<String, dynamic> json) {
    return ReportStats(
      pending: json['pending'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
      avgScore: (json['avg_score'] ?? 0).toDouble(),
      unreadNotifications: json['unread_notifications'] ?? 0,
    );
  }
}

class ReportModel {
  final int reportId;
  final String reportType;
  final String status;
  final String statusLabel;

  final String studentName;
  final String? registrationNo;
  final String? companyName;
  final String? jobTitle;

  final String? submissionDate;
  final String? submittedOn;

  final String? activityPreview;
  final bool hasAttachment;
  final bool isOverdue;

  ReportModel({
    required this.reportId,
    required this.reportType,
    required this.status,
    required this.statusLabel,
    required this.studentName,
    this.registrationNo,
    this.companyName,
    this.jobTitle,
    this.submissionDate,
    this.submittedOn,
    this.activityPreview,
    required this.hasAttachment,
    required this.isOverdue,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      reportId: json['report_id'],
      reportType: json['report_type'] ?? '',
      status: json['status'] ?? '',
      statusLabel: json['status_label'] ?? '',
      studentName: json['student_name'] ?? '',
      registrationNo: json['registration_no'],
      companyName: json['company_name'],
      jobTitle: json['job_title'],
      submissionDate: json['submission_date'],
      submittedOn: json['submitted_on'],
      activityPreview: json['activity_preview'],
      hasAttachment: json['has_attachment'] ?? false,
      isOverdue: json['is_overdue'] ?? false,
    );
  }
}

class ReportListResponse {
  final ReportStats stats;
  final List<ReportModel> reports;
  final int currentPage;
  final int totalPages;
  ReportListResponse({required this.stats, required this.reports, required this.currentPage, required this.totalPages});
  factory ReportListResponse.fromJson(Map<String, dynamic> json) {
    return ReportListResponse(
      stats: ReportStats.fromJson(json['stats']),
      reports: (json['reports'] as List).map((e) => ReportModel.fromJson(e)).toList(),
      currentPage: json['pagination']['current_page'],
      totalPages: json['pagination']['total_pages'],
    );
  }
}

class ReportDetailsModel {
  final int reportId;
  final String reportLabel;
  final String status;
  final String statusLabel;
  final bool canEvaluate;
  final bool canEdit;
  final String? submittedDate;
  final String? activityDescription;
  final String? learningOutcomes;
  final String? challenges;
  final String? attachmentPath;
  final String studentName;
  final String studentEmail;
  final String? studentPhone;
  final String? registrationNo;
  final String? departmentName;
  final String? companyName;
  final double? score;
  final String? feedback;
  ReportDetailsModel({
    required this.reportId,
    required this.reportLabel,
    required this.status,
    required this.statusLabel,
    required this.canEvaluate,
    required this.canEdit,
    this.submittedDate,
    this.activityDescription,
    this.learningOutcomes,
    this.challenges,
    this.attachmentPath,
    required this.studentName,
    required this.studentEmail,
    this.studentPhone,
    this.registrationNo,
    this.departmentName,
    this.companyName,
    this.score,
    this.feedback,
  });
  factory ReportDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReportDetailsModel(
      reportId: json['report_id'],
      reportLabel: json['report_label'] ?? '',
      status: json['status'] ?? '',
      statusLabel: json['status_label'] ?? '',
      canEvaluate: json['can_evaluate'] ?? false,
      canEdit: json['can_edit'] ?? false,
      submittedDate: json['submitted_date'],
      activityDescription: json['activity_description'],
      learningOutcomes: json['learning_outcomes'],
      challenges: json['challenges'],
      attachmentPath: json['attachment_path'],
      studentName: json['student_name'] ?? '',
      studentEmail: json['student_email'] ?? '',
      studentPhone: json['student_phone'],
      registrationNo: json['registration_no'],
      departmentName: json['department_name'],
      companyName: json['company_name'],
      score: json['score'] != null ? (json['score']).toDouble() : null,
      feedback: json['feedback'],
    );
  }
}
