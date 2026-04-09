class GuideProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String department;
  final String college;

  GuideProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
    required this.college,
  });

  factory GuideProfileModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'];

    return GuideProfileModel(
      id: int.parse(profile['id'].toString()),
      name: profile['name'] ?? '',
      email: profile['email'] ?? '',
      phone: profile['phone'] ?? '',
      designation: profile['designation'] ?? '',
      department: profile['department'] ?? '',
      college: profile['college'] ?? '',
    );
  }
}
