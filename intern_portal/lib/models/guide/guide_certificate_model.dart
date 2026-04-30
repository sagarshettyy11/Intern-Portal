class GuideCertificateResponse {
  final GuideCertificateStats stats;
  final List<GuideCertificate> certificates;

  GuideCertificateResponse({required this.stats, required this.certificates});

  factory GuideCertificateResponse.fromJson(Map<String, dynamic> json) {
    return GuideCertificateResponse(
      stats: GuideCertificateStats.fromJson(json['stats']),
      certificates: (json['certificates'] as List).map((e) => GuideCertificate.fromJson(e)).toList(),
    );
  }
}

class GuideCertificateStats {
  final int total;
  final int issued;
  final int pending;

  GuideCertificateStats({required this.total, required this.issued, required this.pending});

  factory GuideCertificateStats.fromJson(Map<String, dynamic> json) {
    return GuideCertificateStats(
      total: _toInt(json['total']),
      issued: _toInt(json['issued']),
      pending: _toInt(json['pending']),
    );
  }
}

enum ACFilterTab { all, issued, pending }

class GuideCertificate {
  final int internshipId;
  final String name;
  final String regNo;
  final String company;
  final String role;
  final String domain;
  final String duration;
  final String? verificationId;
  final String? issuedDate;
  final String status;
  final String? fileUrl;

  GuideCertificate({
    required this.internshipId,
    required this.name,
    required this.regNo,
    required this.company,
    required this.role,
    required this.domain,
    required this.duration,
    this.verificationId,
    this.issuedDate,
    required this.status,
    this.fileUrl,
  });

  factory GuideCertificate.fromJson(Map<String, dynamic> json) {
    final student = json['student'] ?? {};
    final duration = json['duration'] ?? {};
    final cert = json['certificate'] ?? {};

    return GuideCertificate(
      internshipId: json['internship_id'],
      name: student['name'] ?? '',
      regNo: student['registration_no'] ?? '',
      company: json['company_name'] ?? '',
      role: json['job_title'] ?? '',
      domain: json['internship_domain'] ?? '',
      duration: "${duration['start_date'] ?? ''} - ${duration['end_date'] ?? ''}",
      verificationId: cert['verification_id'],
      issuedDate: cert['issued_date'],
      status: cert['status'] ?? 'Pending',
      fileUrl: cert['file_url'],
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
