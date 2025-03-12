import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(lightTheme);

  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark();

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event == ThemeEvent.toggle) {
      yield state == lightTheme ? darkTheme : lightTheme;
    }
  }
}
