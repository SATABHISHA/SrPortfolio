import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: const Text("My Resume"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeEvent.toggle);
            },
          ),
        ],
      ),

      body: FutureBuilder<ResumeModel?>(
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
    );
  }
}
