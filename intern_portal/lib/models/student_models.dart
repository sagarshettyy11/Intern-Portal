class StudentProfile {
  final Map<String, dynamic> personal;
  final Map<String, dynamic> academic;
  final Map<String, dynamic>? guide;
  final Map<String, dynamic>? internship;
  StudentProfile({required this.personal, required this.academic, this.guide, this.internship});
  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      personal: json['personal'] ?? {},
      academic: json['academic'] ?? {},
      guide: json['guide'],
      internship: json['internship_status'],
    );
  }
}
