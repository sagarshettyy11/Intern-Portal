class ReportRequest {
  final String reportType;
  final String periodStart;
  final String periodEnd;
  final String description;
  final String learningOutcomes;
  final String challenges;
  ReportRequest({
    required this.reportType,
    required this.periodStart,
    required this.periodEnd,
    required this.description,
    required this.learningOutcomes,
    required this.challenges,
  });
  Map<String, String> toMap() {
    return {
      "report_type": reportType,
      "period_start": periodStart,
      "period_end": periodEnd,
      "activity_description": description,
      "learning_outcomes": learningOutcomes,
      "challenges": challenges,
    };
  }
}

class ReportModel {
  final int id;
  final String reportType;
  final String? periodStart;
  final String? periodEnd;
  final String status;
  final String description;
  final String learningOutcomes;
  final String challenges;
  final String? attachmentUrl;
  ReportModel({
    required this.id,
    required this.reportType,
    this.periodStart,
    this.periodEnd,
    required this.status,
    required this.description,
    required this.learningOutcomes,
    required this.challenges,
    this.attachmentUrl,
  });
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['report_id'],
      reportType: json['report_type'] ?? '',
      periodStart: json['period_start'],
      periodEnd: json['period_end'],
      status: json['status'] ?? '',
      description: json['activity_description'] ?? '',
      learningOutcomes: json['learning_outcomes'] ?? '',
      challenges: json['challenges'] ?? '',
      attachmentUrl: json['attachment_url'],
    );
  }
}

class ReportMeta {
  final List<String> reportTypes;
  ReportMeta({required this.reportTypes});
  factory ReportMeta.fromJson(Map<String, dynamic> json) {
    return ReportMeta(reportTypes: List<String>.from(json['report_types'] ?? []));
  }
}

class ReportResponse {
  final bool success;
  final String message;
  final int? reportId;
  ReportResponse({required this.success, required this.message, this.reportId});
  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      reportId: json['data']?['report_id'],
    );
  }
}

class ReportListItem {
  final int id;
  final String type;
  final String status;
  final bool isOverdue;
  ReportListItem({required this.id, required this.type, required this.status, required this.isOverdue});
  factory ReportListItem.fromJson(Map<String, dynamic> json) {
    return ReportListItem(
      id: json['report_id'],
      type: json['report_type'] ?? '',
      status: json['display_status'] ?? '',
      isOverdue: json['is_overdue'] ?? false,
    );
  }
}
