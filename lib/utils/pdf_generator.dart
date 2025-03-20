import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import '../data/models/resume_model.dart';

Future<File?> generateResumePDF(ResumeModel resume) async {
  final pdf = pw.Document();
  // ✅ Load Material Icons for PDF
  final ttf = pw.Font.ttf(await rootBundle.load("fonts/MaterialIcons-Regular.ttf"));

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(16),
      build: (pw.Context context) => [
        // ✅ Name & Contact Info
        pw.Text(resume.name, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),

        pw.Row(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    // pw.Icon(pw.IconData(0xe0be), size: 18, color: PdfColors.deepOrange), // Email Icon
                    pw.Text("📧", style: pw.TextStyle(fontSize: 18, color: PdfColors.deepOrange)), // Email Icon
                    pw.SizedBox(width: 8),
                    pw.Text(resume.email, style: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  children: [
                    pw.Icon(pw.IconData(0xe0b0), size: 18, color: PdfColors.green), // Phone Icon
                    pw.SizedBox(width: 8),
                    pw.Text(resume.contact, style: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
                  ],
                ),
              ],
            ),

            pw.Spacer(),

            // ✅ Profile Links
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Icon(pw.IconData(0xe30d), size: 18, color: PdfColors.blue), // Work Icon
                    pw.SizedBox(width: 8),
                    pw.Text(resume.portfolioLink, style: pw.TextStyle(fontSize: 16, color: PdfColors.blue)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  children: [
                    pw.Icon(pw.IconData(0xe86f), size: 18, color: PdfColors.teal), // GitHub Icon
                    pw.SizedBox(width: 8),
                    pw.Text(resume.githubLink, style: pw.TextStyle(fontSize: 16, color: PdfColors.blue)),
                  ],
                ),
              ],
            ),
          ],
        ),
        pw.Divider(),

        // ✅ Summary Section
        pw.Text("Summary:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Text(resume.summary.isNotEmpty ? resume.summary : "No summary available.",
            style: const pw.TextStyle(fontSize: 14)),
        pw.Divider(),

        // ✅ Skills Section
        pw.Text("Skills:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Wrap(
          spacing: 8,
          runSpacing: 4,
          children: resume.skills.map((skill) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                color: PdfColors.lightBlue100,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Text(skill, style: pw.TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
        pw.Divider(),

        // ✅ Experience Section
        pw.Text("Experience:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
        pw.Column(
          children: resume.experience.map((exp) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("• ${exp.company}",
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
                pw.Text("${exp.role} (${exp.duration})",
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800)),
                pw.SizedBox(height: 5),

                // ✅ Display all projects under each experience
                if (exp.projects.isNotEmpty) ...[
                  pw.Text("Projects:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                  pw.Column(
                    children: exp.projects.map((project) {
                      return pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 4),
                        padding: const pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.blue, width: 1),
                          borderRadius: pw.BorderRadius.circular(10),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Icon(pw.IconData(0xe06c), size: 14, color: PdfColors.green), // Pin icon
                                pw.SizedBox(width: 5),
                                pw.Text(project.name,
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(project.description,
                                style: const pw.TextStyle(fontSize: 12),
                                softWrap: true,
                                maxLines: 10,
                                overflow: pw.TextOverflow.visible),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
                pw.SizedBox(height: 10),
              ],
            );
          }).toList(),
        ),
        pw.Divider(),

        // ✅ Education Section
        pw.Text("Education:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Column(
          children: resume.education.map((edu) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(edu.degree, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
                pw.Text(edu.college, style: const pw.TextStyle(fontSize: 14)),
                pw.Row(
                  children: [
                    pw.Icon(pw.IconData(0xe0e1), size: 14, color: PdfColors.blueAccent),
                    pw.SizedBox(width: 5),
                    pw.Text(edu.year, style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey)),
                  ],
                ),
                pw.SizedBox(height: 8),
              ],
            );
          }).toList(),
        ),
        pw.Divider(),
      ],
    ),
  );

  // ✅ Handle Web & Mobile separately
  if (kIsWeb) {
    Uint8List bytes = await pdf.save();
    savePdfForWeb(bytes);
    return null; // ❌ No file returned for Web
  } else {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    return file; // ✅ Return file for Mobile & Desktop
  }
}

// ✅ Web: Save PDF using `universal_html`
void savePdfForWeb(Uint8List bytes) {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "resume.pdf")
    ..click();
  html.Url.revokeObjectUrl(url);
}
