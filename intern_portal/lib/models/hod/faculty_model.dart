class FacultyPerformance {
  final FacultyStats stats;
  final List<FacultyGuide> guides;
  FacultyPerformance({required this.stats, required this.guides});
  factory FacultyPerformance.fromJson(Map<String, dynamic> json) {
    return FacultyPerformance(
      stats: FacultyStats.fromJson(json['stats']),
      guides: (json['data'] as List).map((e) => FacultyGuide.fromJson(e)).toList(),
    );
  }
}

class FacultyStats {
  final int totalGuides;
  final int totalStudents;
  final double avgCompletion;
  FacultyStats({required this.totalGuides, required this.totalStudents, required this.avgCompletion});
  factory FacultyStats.fromJson(Map<String, dynamic> json) {
    int parse(dynamic v) => int.tryParse(v.toString()) ?? 0;
    double parseDouble(dynamic v) => double.tryParse(v.toString()) ?? 0;
    return FacultyStats(
      totalGuides: parse(json['total_guides']),
      totalStudents: parse(json['total_students_approved']),
      avgCompletion: parseDouble(json['avg_dept_completion']),
    );
  }
}

class FacultyGuide {
  final int id;
  final String name;
  final String email;
  final String designation;
  final String department;
  final int totalAssigned;
  final int completed;
  final int ongoing;
  final int pending;
  final int completionRate;
  final double rating;
  FacultyGuide({
    required this.id,
    required this.name,
    required this.email,
    required this.designation,
    required this.department,
    required this.totalAssigned,
    required this.completed,
    required this.ongoing,
    required this.pending,
    required this.completionRate,
    required this.rating,
  });
  factory FacultyGuide.fromJson(Map<String, dynamic> json) {
    int parse(dynamic v) => int.tryParse(v.toString()) ?? 0;
    double parseDouble(dynamic v) => double.tryParse(v.toString()) ?? 0;
    return FacultyGuide(
      id: parse(json['faculty_id']),
      name: json['faculty_name'] ?? '',
      email: json['faculty_email'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department_name'] ?? '',
      totalAssigned: parse(json['total_assigned']),
      completed: parse(json['completed']),
      ongoing: parse(json['ongoing']),
      pending: parse(json['pending']),
      completionRate: parse(json['completion_rate']),
      rating: parseDouble(json['rating']),
    );
  }
}
