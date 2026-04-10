class AdminProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String department;
  final String college;
  final String role;
  final String status;

  AdminProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.college,
    required this.role,
    required this.status,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      college: json['college'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
