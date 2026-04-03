class FacultyProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String department;
  final String college;

  FacultyProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.college,
  });

  factory FacultyProfileModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'];

    return FacultyProfileModel(
      id: profile['id'] ?? 0,
      name: profile['name'] ?? '',
      email: profile['email'] ?? '',
      phone: profile['phone'] ?? '',
      designation: profile['designation'] ?? '',
      department: profile['department'] ?? '',
      college: profile['college'] ?? '',
    );
  }
}