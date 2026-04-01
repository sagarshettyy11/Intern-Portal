class GuideDashboardModel {
  final int totalApproved;
  final int currentlyActive;
  final int completed;
  final List<GuideStudent> students;
  GuideDashboardModel({
    required this.totalApproved,
    required this.currentlyActive,
    required this.completed,
    required this.students,
  });
  factory GuideDashboardModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'];
    final students = json['students']['data'] as List;
    return GuideDashboardModel(
      totalApproved: stats['total_approved'] ?? 0,
      currentlyActive: stats['currently_active'] ?? 0,
      completed: stats['completed'] ?? 0,
      students: students.map((e) => GuideStudent.fromJson(e)).toList(),
    );
  }
}

class GuideStudent {
  final String name;
  final String email;
  final String company;
  final String status;
  final int internshipId;
  GuideStudent({
    required this.name,
    required this.email,
    required this.company,
    required this.status,
    required this.internshipId,
  });
  factory GuideStudent.fromJson(Map<String, dynamic> json) {
    return GuideStudent(
      name: json['student_name'] ?? '',
      email: json['student_email'] ?? '',
      company: json['company_name'] ?? '',
      status: json['status_display'] ?? '',
      internshipId: int.tryParse(json['internship_id'].toString()) ?? 0,
    );
  }
}

class GuideRequestModel {
  final String companyName;
  final String studentName;
  final String status;

  GuideRequestModel.fromJson(Map<String, dynamic> json)
    : companyName = json['company_name'],
      studentName = json['student_name'],
      status = json['status_display'];
}
