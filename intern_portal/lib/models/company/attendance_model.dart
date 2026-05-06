class AttendanceSummary {
  final int totalStudents;
  final double avgAttendance;
  AttendanceSummary({required this.totalStudents, required this.avgAttendance});
  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      totalStudents: int.tryParse(json['total_students'].toString()) ?? 0,
      avgAttendance: double.tryParse(json['average_attendance'].toString()) ?? 0.0,
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
      internshipId: int.tryParse(json['internship_id'].toString()) ?? 0,
      name: json['student_name'] ?? '',
      regNo: json['registration_no'] ?? '',
      domain: json['internship_domain'] ?? '',
      period: "${json['start_date'] ?? ''} - ${json['end_date'] ?? ''}",
      attendance: double.tryParse(json['attendance_pct'].toString()) ?? 0.0,
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

  final String? startDate;
  final String? endDate;

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
    this.startDate,
    this.endDate,
  });

  factory AttendanceInfo.fromJson(Map<String, dynamic> json) {
    return AttendanceInfo(
      internshipId: int.tryParse(json['internship_id'].toString()) ?? 0,
      name: json['student_name'] ?? '',
      regNo: json['registration_no'] ?? '',
      domain: json['internship_domain'] ?? '',
      college: json['college_name'] ?? '',
      department: json['department_name'] ?? '',
      jobTitle: json['job_title'] ?? '',
      attendance: double.tryParse(json['attendance_pct'].toString()) ?? 0.0,
      status: json['attendance_label'] ?? '',

      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
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
