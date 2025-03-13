import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/resume_bloc.dart';
import '../../utils/pdf_generator.dart';
import '../widgets/resume_card.dart';

class ResumeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final resume = (context.read<ResumeBloc>().state as ResumeLoaded).resume;
              final file = await generateResumePDF(resume);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("PDF saved at ${file.path}")),
              );
            },
          ),
        ],),
      body: BlocBuilder<ResumeBloc, ResumeState>(
        builder: (context, state) {
          if (state is ResumeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResumeLoaded) {
            var resume = state.resume;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ResumeCard(resume: resume), // Using your ResumeCard here
            );
          }
          return const Center(child: Text('Error loading resume'));
        },
      ),
    );
  }
}
