class DepartmentSummary {
  final int totalStudents;
  final int applied;
  final int ongoing;
  final int completed;
  final int pending;
  final int notApplied;

  DepartmentSummary({
    required this.totalStudents,
    required this.applied,
    required this.ongoing,
    required this.completed,
    required this.pending,
    required this.notApplied,
  });

  factory DepartmentSummary.fromJson(Map<String, dynamic> json) {
    return DepartmentSummary(
      totalStudents: json['total_students'] ?? 0,
      applied: json['applied'] ?? 0,
      ongoing: json['ongoing'] ?? 0,
      completed: json['completed'] ?? 0,
      pending: json['pending'] ?? 0,
      notApplied: json['not_applied'] ?? 0,
    );
  }
}

class GradeData {
  final String label;
  final int value;
  GradeData({required this.label, required this.value});
  factory GradeData.fromJson(Map<String, dynamic> json) {
    return GradeData(label: json['label'] ?? '', value: json['value'] ?? 0);
  }
}

class StudentData {
  final int studentId;
  final String name;
  final String registrationNo;
  final String email;
  final String year;
  final String guide;
  final String status;
  final String date;

  StudentData({
    required this.studentId,
    required this.name,
    required this.registrationNo,
    required this.email,
    required this.year,
    required this.guide,
    required this.status,
    required this.date,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      studentId: json['student_id'] ?? 0,
      name: json['name'] ?? '',
      registrationNo: json['registration_no'] ?? '',
      email: json['email'] ?? '',
      year: json['year'] ?? '',
      guide: json['guide'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

class DepartmentPerformance {
  final DepartmentSummary summary;
  final List<GradeData> grades;
  final List<StudentData> students;

  DepartmentPerformance({required this.summary, required this.grades, required this.students});

  factory DepartmentPerformance.fromJson(Map<String, dynamic> json) {
    return DepartmentPerformance(
      summary: DepartmentSummary.fromJson(json['summary']),
      grades: (json['grades'] as List).map((e) => GradeData.fromJson(e)).toList(),
      students: (json['students'] as List).map((e) => StudentData.fromJson(e)).toList(),
    );
  }
}
