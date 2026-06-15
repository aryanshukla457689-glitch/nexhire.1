class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final List<String> skills;
  final String? education;
  final int? experience;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.skills = const [],
    this.education,
    this.experience,
  });

  // Convert object to Map (for Firestore/JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'skills': skills,
      'education': education,
      'experience': experience,
    };
  }

  // Create object from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      profileImage: map['profileImage'],
      skills: List<String>.from(map['skills'] ?? []),
      education: map['education'],
      experience: map['experience'],
    );
  }

  // Copy with updated values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    List<String>? skills,
    String? education,
    int? experience,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email)';
  }
}