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
}
