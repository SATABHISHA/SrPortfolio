import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/resume_model.dart';
import '../../data/repositories/firestore_service.dart';
import '../../logic/bloc/theme_bloc.dart';
import '../../utils/pdf_generator.dart';
import '../widgets/resume_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to show gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // colors: [Color(0xFF89CFF0), Color(0xFF6A5ACD)], // Light Blue to Soft Purple
              colors: [Color(0xFFD5ECC1), Color(0xFF8FC2EC)], // Light Blue to Soft Purple
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              "images/logoportfolio.png",  // 🔹 Use your own logo image here
              height: 40,  // Adjust based on your logo size
              width: 40,
            ),
            const SizedBox(width: 10),
            Text(
              "Dream Big, Work Smart",
              style: GoogleFonts.lora(  // Lora is elegant & soothing
                fontSize: 22,
                fontWeight: FontWeight.w600, // Softer than bold
                color: Colors.white,
                letterSpacing: 1.2, // Slight spacing for elegance
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeEvent.toggle);
            },
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB5E48C), // Soft lime green
              Color(0xFF76C893), // Teal-green for depth
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<ResumeModel?>(
          future: FirestoreService.getResumeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No Resume Found."));
            }

            ResumeModel resume = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ResumeCard(resume: resume),
                  const SizedBox(height: 20),

                  // PDF Download Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text("Download PDF"),
                    onPressed: () async {
                      final file = await generateResumePDF(resume);
                      if (file != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("PDF saved at ${file.path}")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("PDF downloaded successfully.")),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
