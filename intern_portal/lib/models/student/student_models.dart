class StudentProfile {
  final Personal personal;
  final Academic academic;
  final Guide? guide;
  final InternshipStatus? internship;
  StudentProfile({required this.personal, required this.academic, this.guide, this.internship});
  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      personal: Personal.fromJson(json['personal']),
      academic: Academic.fromJson(json['academic']),
      guide: json['guide'] != null ? Guide.fromJson(json['guide']) : null,
      internship: json['internship_status'] != null ? InternshipStatus.fromJson(json['internship_status']) : null,
    );
  }
}

class Personal {
  final int studentId;
  final String name;
  final String email;
  final String phone;
  final String registrationNo;
  final String gender;
  final String? dob;
  final String address;
  final String status;
  Personal({
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.registrationNo,
    required this.gender,
    this.dob,
    required this.address,
    required this.status,
  });
  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      studentId: json['student_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      registrationNo: json['registration_no'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'],
      address: json['residential_address'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Academic {
  final String department;
  final String university;
  final String year;
  final String? batch;
  final double? cgpa;
  Academic({required this.department, required this.university, required this.year, required this.batch, this.cgpa});
  factory Academic.fromJson(Map<String, dynamic> json) {
    return Academic(
      department: json['department_name'] ?? '',
      university: json['university_name'] ?? '',
      year: json['year_of_study'] ?? '',
      batch: (json['batch'] ?? '').toString(),
      cgpa: json['cgpa'] != null ? double.tryParse(json['cgpa'].toString()) : null,
    );
  }
}

class Guide {
  final String name;
  final String email;
  final String designation;
  final String phone;
  Guide({required this.name, required this.email, required this.designation, required this.phone});
  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      designation: json['designation'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class InternshipStatus {
  final String company;
  final String status;
  final int completionPct;
  final String? startDate;
  final String? endDate;
  InternshipStatus({
    required this.company,
    required this.status,
    required this.completionPct,
    this.startDate,
    this.endDate,
  });
  factory InternshipStatus.fromJson(Map<String, dynamic> json) {
    return InternshipStatus(
      company: json['company'] ?? '',
      status: json['status'] ?? '',
      completionPct: json['completion_pct'] ?? 0,
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}
