class AdminProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String department;
  final String college;
  final String address;
  final String website;
  // stats
  final int totalStudents;
  final int totalFaculty;
  final int totalDepts;
  AdminProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.college,
    required this.address,
    required this.website,
    required this.totalStudents,
    required this.totalFaculty,
    required this.totalDepts,
  });

  factory AdminProfile.fromApi(Map<String, dynamic> json) {
    final college = json['college'] ?? {};
    final stats = json['stats'] ?? {};
    return AdminProfile(
      id: college['college_id'] ?? 0,
      name: college['college_name'] ?? 'Admin',
      email: college['email'] ?? '',
      phone: college['phone'] ?? '',
      designation: 'College Admin',
      department: 'Administration',
      college: college['college_name'] ?? '',
      address: college['address'] ?? '',
      website: college['website'] ?? '',
      totalStudents: stats['total_students'] ?? 0,
      totalFaculty: stats['total_faculty'] ?? 0,
      totalDepts: stats['total_depts'] ?? 0,
    );
  }
}
