import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(lightTheme) {
    on<ThemeEvent>((event, emit) {
      if (event == ThemeEvent.toggle) {
        emit(state == lightTheme ? darkTheme : lightTheme);
      }
    });
  }

  static final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
  );
}
