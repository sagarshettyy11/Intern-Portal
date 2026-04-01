class InternshipReviewModel {
  final String studentName;
  final String email;
  final String phone;
  final String regNo;
  final String department;
  final String year;

  final String companyName;
  final String companyAddress;
  final String companyIndustry;
  final String supervisorName;
  final String supervisorEmail;
  final String supervisorPhone;

  final String jobTitle;
  final String workMode;
  final String domain;
  final String startDate;
  final String endDate;
  final String duration;
  final String description;

  final String status;
  final String createdDate;
  final String? rejectionReason;

  InternshipReviewModel({
    required this.studentName,
    required this.email,
    required this.phone,
    required this.regNo,
    required this.department,
    required this.year,
    required this.companyName,
    required this.companyAddress,
    required this.companyIndustry,
    required this.supervisorName,
    required this.supervisorEmail,
    required this.supervisorPhone,
    required this.jobTitle,
    required this.workMode,
    required this.domain,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.description,
    required this.status,
    required this.createdDate,
    this.rejectionReason,
  });

  factory InternshipReviewModel.fromJson(Map<String, dynamic> json) {
    return InternshipReviewModel(
      studentName: json['student_name'] ?? '',
      email: json['student_email'] ?? '',
      phone: json['student_phone'] ?? '',
      regNo: json['registration_no'] ?? '',
      department: json['department_name'] ?? '',
      year: json['academic_year'] ?? '',

      companyName: json['company_name'] ?? '',
      companyAddress: json['company_address'] ?? '',
      companyIndustry: json['company_industry'] ?? '',
      supervisorName: json['industry_guide_name'] ?? '',
      supervisorEmail: json['industry_guide_email'] ?? '',
      supervisorPhone: json['industry_guide_phone'] ?? '',

      jobTitle: json['job_title'] ?? '',
      workMode: json['work_mode'] ?? '',
      domain: json['internship_domain'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      duration: json['company_category'] ?? '',
      description: json['job_description'] ?? '',

      status: json['status'] ?? '',
      createdDate: json['created_date'] ?? '',
      rejectionReason: json['rejection_reason'],
    );
  }
}
