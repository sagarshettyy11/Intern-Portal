class AttendanceSummary {
  final int totalStudents;
  final double avgAttendance;
  AttendanceSummary({required this.totalStudents, required this.avgAttendance});
  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      totalStudents: json['total_students'] ?? 0,
      avgAttendance: (json['average_attendance'] ?? 0).toDouble(),
    );
  }
}

class AttendanceStudent {
  final int internshipId;
  final String name;
  final String regNo;
  final String domain;
  final String period;
  final double attendance;
  final String status;
  AttendanceStudent({
    required this.internshipId,
    required this.name,
    required this.regNo,
    required this.domain,
    required this.period,
    required this.attendance,
    required this.status,
  });
  factory AttendanceStudent.fromJson(Map<String, dynamic> json) {
    return AttendanceStudent(
      internshipId: json['internship_id'],
      name: json['student_name'] ?? '',
      regNo: json['registration_no'] ?? '',
      domain: json['internship_domain'] ?? '',
      period: "${json['start_date'] ?? ''} - ${json['end_date'] ?? ''}",
      attendance: (json['attendance_pct'] ?? 0).toDouble(),
      status: json['attendance_label'] ?? '',
    );
  }
}

class AttendanceResponse {
  final AttendanceSummary summary;
  final List<AttendanceStudent> students;
  AttendanceResponse({required this.summary, required this.students});
  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      summary: AttendanceSummary.fromJson(json['summary']),
      students: (json['students'] as List).map((e) => AttendanceStudent.fromJson(e)).toList(),
    );
  }
}
