import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/models/resume_model.dart';

class ResumeCard extends StatelessWidget {
  final ResumeModel resume;

  const ResumeCard({Key? key, required this.resume}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Animation
            /*Center(
              child: Lottie.asset("assets/animations/profile.json",
                  height: 120, width: 120),
            ),*/
            const SizedBox(height: 10),

            // Name & Contact
            Text(resume.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text("📧 ${resume.email}",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            Text("📞 ${resume.contact}",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const Divider(),

            // Skills
            Text("Skills:", style: Theme.of(context).textTheme.headlineMedium),
            Wrap(
              spacing: 8.0,
              children: resume.skills
                  .map((skill) => Chip(label: Text(skill)))
                  .toList(),
            ),
            const Divider(),

            // Experience
            Text("Experience:", style: Theme.of(context).textTheme.headlineMedium),
            /*Column(
              children: resume.experience
                  .map(
                    (exp) => ListTile(
                  title: Text(exp.company,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${exp.role} (${exp.duration})"),
                ),
              )
                  .toList(),
            ),*/

            Column(
              children: resume.experience.map((exp) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    title: Text(exp.company,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${exp.role} (${exp.duration})"),
                    children: exp.projects.isNotEmpty
                        ? exp.projects.map((project) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "📌 ${project.name}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(project.description,
                                style: const TextStyle(fontSize: 14, color: Colors.black54)),
                            const SizedBox(height: 6),
                          ],
                        ),
                      );
                    }).toList()
                        : [const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No projects available.", style: TextStyle(color: Colors.grey)),
                    )],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
