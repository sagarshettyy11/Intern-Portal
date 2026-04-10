class DashboardData {
  final Map<String, dynamic> overview;
  final Map<String, dynamic> stats;
  final List deptStats;
  final Map<String, dynamic> statusBreakdown;
  final List recentRegistrations;

  DashboardData({
    required this.overview,
    required this.stats,
    required this.deptStats,
    required this.statusBreakdown,
    required this.recentRegistrations,
  });

  factory DashboardData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DashboardData(overview: {}, stats: {}, deptStats: [], statusBreakdown: {}, recentRegistrations: []);
    }
    return DashboardData(
      overview: json['college_overview'] ?? {},
      stats: json['registration_stats'] ?? {},
      deptStats: json['dept_stats'] is List ? json['dept_stats'] : [],
      statusBreakdown: json['status_breakdown'] is Map ? Map<String, dynamic>.from(json['status_breakdown']) : {},
      recentRegistrations: json['recent_registrations'] is List ? List.from(json['recent_registrations']) : [],
    );
  }
}
