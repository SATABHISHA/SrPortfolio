import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_portfolio/presentation/screens/home_screen.dart';

import 'data/repositories/resume_repository.dart';
import 'logic/bloc/resume_bloc.dart';
import 'logic/bloc/theme_bloc.dart';

Future<void> main() async {
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); //---for mobile
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBvzppdr8w9JZ4G1eXoiz-XlywonEJ9aHc", // Your apiKey
      appId: "1:495491634966:web:3f9780db624b9c1d21e237", // Your appId
      messagingSenderId: "495491634966", // Your messagingSenderId
      projectId: "srportfolio-6c702", // Your projectId
    ),
  ); //---for web
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (_) => ThemeBloc(),
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),  // For Dark/Light Mode
        BlocProvider(create: (_) => ResumeBloc(ResumeRepository())), // Fetch Resume Data
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Resume App',
            theme: theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

