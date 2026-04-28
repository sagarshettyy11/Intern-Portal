class CompanyProfile {
  final int id;
  final String name;
  final String person;
  final String email;
  final String phone;
  final String type;
  final String category;

  CompanyProfile({
    required this.id,
    required this.name,
    required this.person,
    required this.email,
    required this.phone,
    required this.type,
    required this.category,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      id: json['id'],
      name: json['name'],
      person: json['person'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      category: json['category'],
    );
  }
}