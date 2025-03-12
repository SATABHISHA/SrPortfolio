import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data/models/resume_model.dart';

Future<File> generateResumePDF(ResumeModel resume) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(resume.name, style: pw.TextStyle(fontSize: 24)),
          pw.Text("Contact: ${resume.contact}"),
          pw.Text("Email: ${resume.email}"),
          pw.Text("Skills: ${resume.skills.join(", ")}"),
          pw.SizedBox(height: 10),
          pw.Text("Experience", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...resume.experience.map((exp) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("${exp.company} - ${exp.role} (${exp.duration})"),
              ...exp.projects.map((proj) => pw.Text("• ${proj.name}: ${proj.description}")),
              pw.SizedBox(height: 5),
            ],
          )),
        ],
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/resume.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}
