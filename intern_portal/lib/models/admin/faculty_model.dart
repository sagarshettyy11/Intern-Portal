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
}
