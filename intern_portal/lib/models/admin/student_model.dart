class StudentModel {
  final int studentId;
  final String name;
  final String email;
  final String regNo;
  final String batch;
  final String yearOfStudy;
  final String status;
  final String? departmentName;
  final int? departmentId;
  final String initials;
  final String? phone;
  StudentModel({
    required this.studentId,
    required this.name,
    required this.email,
    required this.regNo,
    required this.batch,
    required this.yearOfStudy,
    required this.status,
    required this.initials,
    this.phone,
    this.departmentName,
    this.departmentId,
  });
  bool get isActive => status == 'Active';
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['student_id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      regNo: json['registration_no'] ?? '',
      batch: json['batch'] ?? '',
      phone: json['phone'] ?? '',
      yearOfStudy: json['year_of_study'] ?? '',
      status: json['status'] ?? 'Inactive',
      departmentName: json['department_name'],
      departmentId: json['department_id'],
      initials: json['initials'] ?? '',
    );
  }
}

class StudentStats {
  final int total;
  final int active;
  final int inactive;
  StudentStats({required this.total, required this.active, required this.inactive});
  factory StudentStats.fromJson(Map<String, dynamic> json) {
    return StudentStats(total: json['total'] ?? 0, active: json['active'] ?? 0, inactive: json['inactive'] ?? 0);
  }
}

class StudentListResponse {
  final List<StudentModel> students;
  final StudentStats stats;
  StudentListResponse({required this.students, required this.stats});
  factory StudentListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return StudentListResponse(
      students: (data['students'] as List? ?? []).map((e) => StudentModel.fromJson(e)).toList(),
      stats: StudentStats.fromJson(data['stats'] ?? {}),
    );
  }
}
