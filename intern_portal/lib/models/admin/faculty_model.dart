class Faculty {
  final int id;
  final int? departmentId;
  final String name;
  final String initials;
  final String role;
  final bool isActive;
  final String department;
  final String designation;
  final String? email;
  final String? phone;
  const Faculty({
    required this.id,
    required this.name,
    required this.initials,
    required this.role,
    required this.isActive,
    required this.department,
    required this.designation,
    this.departmentId,
    this.email,
    this.phone,
  });
  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['faculty_id'],
      name: json['faculty_name'] ?? '',
      initials: json['initials'] ?? '',
      role: json['login_role'] ?? (json['is_hod'] == true ? 'HOD' : 'Guide'),
      isActive: json['status'] == 'Active',
      department: json['department_name'] ?? '',
      designation: json['designation'] ?? '',
      departmentId: json['department_id'],
      email: json['faculty_email'] ?? '',
      phone: json['faculty_contact'] ?? '',
    );
  }
}
