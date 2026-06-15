class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String salary;
  final String jobType;
  final String applyUrl;
  final List<String> skills;
  final DateTime? postedDate;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.salary,
    required this.jobType,
    required this.applyUrl,
    this.skills = const [],
    this.postedDate,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'salary': salary,
      'jobType': jobType,
      'applyUrl': applyUrl,
      'skills': skills,
      'postedDate': postedDate?.toIso8601String(),
    };
  }

  // Create object from Map
  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary'] ?? '',
      jobType: map['jobType'] ?? '',
      applyUrl: map['applyUrl'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      postedDate: map['postedDate'] != null
          ? DateTime.parse(map['postedDate'])
          : null,
    );
  }

  // Copy with
  JobModel copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    String? description,
    String? salary,
    String? jobType,
    String? applyUrl,
    List<String>? skills,
    DateTime? postedDate,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      description: description ?? this.description,
      salary: salary ?? this.salary,
      jobType: jobType ?? this.jobType,
      applyUrl: applyUrl ?? this.applyUrl,
      skills: skills ?? this.skills,
      postedDate: postedDate ?? this.postedDate,
    );
  }

  @override
  String toString() {
    return 'JobModel(title: $title, company: $company)';
  }
}