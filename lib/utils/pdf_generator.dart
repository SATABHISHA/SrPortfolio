import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data/models/resume_model.dart';
import 'package:flutter/services.dart' show rootBundle;

// Import `universal_html` only for web builds
import 'package:universal_html/html.dart' as html;

Future<File?> generateResumePDF(ResumeModel resume) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(resume.name, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.Text("📧 ${resume.email}"),
          pw.Text("📞 ${resume.contact}"),
          pw.SizedBox(height: 10),
          pw.Text("Skills: ${resume.skills.join(", ")}"),
          pw.SizedBox(height: 10),
          pw.Text("Experience:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...resume.experience.map((exp) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("${exp.company} - ${exp.role} (${exp.duration})", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ...exp.projects.map((proj) => pw.Text("• ${proj.name}: ${proj.description}")),
              pw.SizedBox(height: 5),
            ],
          )),
        ],
      ),
    ),
  );

  // Handle Web and Mobile Separately
  if (kIsWeb) {
    Uint8List bytes = await pdf.save();
    savePdfForWeb(bytes);
    return null;
  } else {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
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