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

class Education {
  String college;
  String degree;
  String year;

  Education({
    required this.college,
    required this.degree,
    required this.year,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      college: json["college"] ?? "",
      degree: json["degree"] ?? "",
      year: json["year"] ?? "",
    );
  }
}


class ResumeModel {
  String name;
  String email;
  String contact;
  String profileImage;
  String summary;
  String portfolioLink;
  String githubLink;
  List<Experience> experience;
  List<Education> education;
  List<String> skills;

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      contact: json["contact"] ?? "",
      summary: json["summary"] ?? "",
      portfolioLink: json["portfolioLink"] ?? "",
      githubLink: json["githubLink"] ?? "",
      profileImage: json["profileImage"] ?? "",
      experience: (json["experience"] as List<dynamic>?)
          ?.map((exp) => Experience.fromJson(exp))
          .toList() ??
          [],
      education: (json["education"] as List<dynamic>?)
          ?.map((edu) => Education.fromJson(edu))
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
    required this.profileImage,
    required this.summary,
    required this.education,
    required this.portfolioLink,
    required this.githubLink,
  });
}
