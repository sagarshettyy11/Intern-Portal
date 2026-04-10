enum InternshipStatus { active, inactive }

enum InternshipMode { online, offline, hybrid }

class Internship {
  final int id;
  final String name;
  final String year;
  final String duration;
  final InternshipMode mode;
  final InternshipStatus status;
  final DateTime? createdDate;
  final List<int> departments;
  Internship({
    required this.id,
    required this.name,
    required this.year,
    required this.duration,
    required this.mode,
    required this.status,
    required this.createdDate,
    required this.departments,
  });
  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: int.parse(json['internship_master_id'].toString()),
      name: json['internship_name'] ?? '',
      year: json['year'] ?? '',
      duration: json['duration'] ?? '',
      mode: _parseMode(json['mode']),
      status: _parseStatus(json['status']),
      createdDate: json['created_date'] != null ? DateTime.tryParse(json['created_date']) : null,
      departments: (json['departments'] ?? '')
          .toString()
          .split(',')
          .where((e) => e.isNotEmpty)
          .map((e) => int.parse(e))
          .toList(),
    );
  }

  static InternshipMode _parseMode(String? mode) {
    switch (mode) {
      case 'Offline':
        return InternshipMode.offline;
      case 'Hybrid':
        return InternshipMode.hybrid;
      default:
        return InternshipMode.online;
    }
  }

  static InternshipStatus _parseStatus(String? status) {
    return status == 'Inactive' ? InternshipStatus.inactive : InternshipStatus.active;
  }
}
