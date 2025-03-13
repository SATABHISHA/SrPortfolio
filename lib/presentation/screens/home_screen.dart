import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/resume_model.dart';
import '../../data/repositories/firestore_service.dart';
import '../../logic/bloc/theme_bloc.dart';
import '../widgets/resume_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Resume"),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            context.read<ThemeBloc>().add(ThemeEvent.toggle);
          },
        ),
      ],),

      body: FutureBuilder<ResumeModel?>(
        future: FirestoreService.getResumeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No Resume Found."));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ResumeCard(resume: snapshot.data!),
          );
        },
      ),
    );
  }
}
