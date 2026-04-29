class HodDashboard {
  final String departmentName;
  final Stats stats;
  final List<RecentApproval> recentApprovals;
  final List<GuideLoad> guideLoads;
  final Map<String, BatchYear> batchYears;
  HodDashboard({
    required this.departmentName,
    required this.stats,
    required this.recentApprovals,
    required this.guideLoads,
    required this.batchYears,
  });
  factory HodDashboard.fromJson(Map<String, dynamic> json) {
    return HodDashboard(
      departmentName: json['department_name'] ?? '',
      stats: Stats.fromJson(json['stats']),
      recentApprovals: (json['recent_approvals'] as List).map((e) => RecentApproval.fromJson(e)).toList(),
      guideLoads: (json['guide_loads'] as List).map((e) => GuideLoad.fromJson(e)).toList(),
      batchYears: (json['batch_years'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, BatchYear.fromJson(value)),
      ),
    );
  }
}

class Stats {
  final int totalStudents;
  final int activeInternships;
  final double completionRate;
  final String avgRating;
  Stats({
    required this.totalStudents,
    required this.activeInternships,
    required this.completionRate,
    required this.avgRating,
  });
  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalStudents: json['total_students'] ?? 0,
      activeInternships: json['active_internships'] ?? 0,
      completionRate: (json['completion_rate'] ?? 0).toDouble(),
      avgRating: json['avg_rating'].toString(),
    );
  }
}

class RecentApproval {
  final String studentName;
  final String guideName;
  final String status;
  final String date;
  RecentApproval({required this.studentName, required this.guideName, required this.status, required this.date});
  factory RecentApproval.fromJson(Map<String, dynamic> json) {
    return RecentApproval(
      studentName: json['student_name'] ?? '',
      guideName: json['guide_name'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

class GuideLoad {
  final String name;
  final int mentees;
  final int ongoing;
  final int pending;
  final int completed;
  GuideLoad({
    required this.name,
    required this.mentees,
    required this.ongoing,
    required this.pending,
    required this.completed,
  });
  factory GuideLoad.fromJson(Map<String, dynamic> json) {
    int parse(dynamic val) => int.tryParse(val.toString()) ?? 0;
    return GuideLoad(
      name: json['faculty_name'] ?? '',
      mentees: parse(json['mentees']),
      ongoing: parse(json['ongoing_count']),
      pending: parse(json['pending_count']),
      completed: parse(json['completed_count']),
    );
  }
}

class BatchYear {
  final int ongoing;
  final int pending;
  final int completed;
  final int notApplied;
  final int total;
  BatchYear({
    required this.ongoing,
    required this.pending,
    required this.completed,
    required this.notApplied,
    required this.total,
  });
  factory BatchYear.fromJson(Map<String, dynamic> json) {
    return BatchYear(
      ongoing: json['ongoing'] ?? 0,
      pending: json['pending'] ?? 0,
      completed: json['completed'] ?? 0,
      notApplied: json['not_applied'] ?? 0,
      total: json['total_batch'] ?? 0,
    );
  }
}
