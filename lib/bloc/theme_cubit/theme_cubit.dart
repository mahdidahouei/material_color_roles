import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(ThemeState(seedColor: Colors.purple, brightness: Brightness.light));

  void changeSeedColor({Color? seedColor, Brightness? brightness}) {
    emit(
      ThemeState(
        seedColor: seedColor ?? state.seedColor,
        brightness: brightness ?? state.brightness,
      ),
    );
  }
}

class ThemeState {
  final Color seedColor;
  final Brightness brightness;

  ThemeState({required this.seedColor, required this.brightness});
}
