class HodProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String department;
  final String college;

  HodProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.college,
  });

  factory HodProfile.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] ?? json;
    return HodProfile(
      id: int.tryParse(profile['id'].toString()) ?? 0,
      name: profile['name'] ?? '',
      email: profile['email'] ?? '',
      phone: profile['phone'] ?? '',
      designation: profile['designation'] ?? '',
      department: profile['department'] ?? '',
      college: profile['college'] ?? '',
    );
  }
}
