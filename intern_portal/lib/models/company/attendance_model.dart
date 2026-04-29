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

class AttendanceInfo {
  final int internshipId;
  final String name;
  final String regNo;
  final String domain;
  final String college;
  final String department;
  final String jobTitle;
  final double attendance;
  final String status;

  AttendanceInfo({
    required this.internshipId,
    required this.name,
    required this.regNo,
    required this.domain,
    required this.college,
    required this.department,
    required this.jobTitle,
    required this.attendance,
    required this.status,
  });

  factory AttendanceInfo.fromJson(Map<String, dynamic> json) {
    return AttendanceInfo(
      internshipId: json['internship_id'],
      name: json['student_name'] ?? '',
      regNo: json['registration_no'] ?? '',
      domain: json['internship_domain'] ?? '',
      college: json['college_name'] ?? '',
      department: json['department_name'] ?? '',
      jobTitle: json['job_title'] ?? '',
      attendance: (json['attendance_pct'] ?? 0).toDouble(),
      status: json['attendance_label'] ?? '',
    );
  }
}

class AttendanceLog {
  final String date;
  final String status;
  final String remarks;

  AttendanceLog({required this.date, required this.status, required this.remarks});

  factory AttendanceLog.fromJson(Map<String, dynamic> json) {
    return AttendanceLog(
      date: json['attendance_date'],
      status: json['attendance_status'],
      remarks: json['remarks'] ?? '',
    );
  }
}

class AttendanceDetailResponse {
  final AttendanceInfo info;
  final List<AttendanceLog> logs;

  AttendanceDetailResponse({required this.info, required this.logs});

  factory AttendanceDetailResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailResponse(
      info: AttendanceInfo.fromJson(json['info']),
      logs: (json['attendance_logs'] as List).map((e) => AttendanceLog.fromJson(e)).toList(),
    );
  }
}
