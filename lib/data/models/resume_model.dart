class Project {
  final String name;
  final String description;

  Project({
    required this.name,
    required this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? "",
      description: json['description'] ?? "",
    );
  }
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final List<Project> projects;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.projects,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'] ?? "",
      role: json['role'] ?? "",
      duration: json['duration'] ?? "",
      projects: (json['projects'] as List<dynamic>?)
          ?.map((proj) => Project.fromJson(proj))
          .toList() ??
          [],
    );
  }
}

class ResumeModel {
  String name;
  String email;
  String contact;
  List<Experience> experience;
  List<String> skills;

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      contact: json["contact"] ?? "",
      experience: (json["experience"] as List<dynamic>?)
          ?.map((exp) => Experience.fromJson(exp))
          .toList() ??
          [],
      skills: List<String>.from(json["skills"] ?? []),
    );
  }

  ResumeModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.experience,
    required this.skills,
  });
}
