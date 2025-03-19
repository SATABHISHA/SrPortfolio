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
            // Profile Image + Lottie Animation (Combined)
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Lottie Animation (Background effect)
                 /* Lottie.asset(
                    "assets/animations/profile.json",
                    height: 140,
                    width: 140,
                  ),*/

                  // Profile Image (Overlapping Lottie animation)
                  /*CircleAvatar(
                    radius: 75,
                    backgroundColor: Color.fromRGBO(77, 227, 169, 1.0), // Optional background color
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "images/sr.png",
                        height: 140,
                        width: 140,
                        fit: BoxFit.fill, // Keep aspect ratio
                      ),
                    ),
                  ),*/

                ],
              ),
            ),
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


            // ✅ Summary Section (NEW)
            Text("Summary:", style: Theme.of(context).textTheme.headlineMedium),
            Text(
              resume.summary.isNotEmpty ? resume.summary : "No summary available.",
              style: const TextStyle(fontSize: 14),
            ),
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
                        ? [const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text('Projects Undertaken:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                      ...exp.projects.map((project) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "📌 ${project.name}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      );
                    }).toList() ]
                        : [const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No projects available.", style: TextStyle(color: Colors.grey)),
                    )],
                  ),
                );
              }).toList(),
            ),


            // ✅ Education Section
            Text("Education:", style: Theme.of(context).textTheme.headlineMedium),
            ...resume.education.map((edu) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edu.degree,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(edu.college, style: const TextStyle(fontSize: 14)),
                  Text("📅 ${edu.year}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            )),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
