class CertificateResponse {
  final CertificateStats stats;
  final List<CertificateModel> certificates;
  CertificateResponse({required this.stats, required this.certificates});
  factory CertificateResponse.fromJson(Map<String, dynamic> json) {
    return CertificateResponse(
      stats: CertificateStats.fromJson(json['stats']),
      certificates: (json['certificates'] as List).map((e) => CertificateModel.fromJson(e)).toList(),
    );
  }
}

class CertificateStats {
  final int totalInterns;
  final int issued;
  final int pending;
  CertificateStats({required this.totalInterns, required this.issued, required this.pending});
  factory CertificateStats.fromJson(Map<String, dynamic> json) {
    return CertificateStats(
      totalInterns: json['total_interns'] ?? 0,
      issued: json['issued'] ?? 0,
      pending: json['pending'] ?? 0,
    );
  }
}

class CertificateModel {
  final int internshipId;
  final int studentId;
  final String studentName;
  final String period;
  final String status;
  final String? certificateUrl;
  final String? verificationId;
  CertificateModel({
    required this.internshipId,
    required this.studentId,
    required this.studentName,
    required this.period,
    required this.status,
    this.certificateUrl,
    this.verificationId,
  });
  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      internshipId: json['internship_id'],
      studentId: json['student_id'],
      studentName: json['student_name'] ?? '',
      period: '${json['start_date'] ?? ''} - ${json['end_date'] ?? ''}',
      status: json['cert_status'] == 'Issued' ? 'ISSUED' : 'NOT UPLOADED',
      certificateUrl: json['certificate_url'],
      verificationId: json['verification_id'],
    );
  }
}
