class CertificateModel {
  final int certificateId;
  final String verificationId;
  final String issuedDate;
  final String companyName;
  final String? domain;
  final String? startDate;
  final String? endDate;

  CertificateModel({
    required this.certificateId,
    required this.verificationId,
    required this.issuedDate,
    required this.companyName,
    this.domain,
    this.startDate,
    this.endDate,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      certificateId: json['certificate_id'],
      verificationId: json['verification_id'],
      issuedDate: json['issued_date'],
      companyName: json['company_name'],
      domain: json['internship_domain'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}