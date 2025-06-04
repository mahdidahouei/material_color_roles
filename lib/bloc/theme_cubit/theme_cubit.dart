import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(Color(0xFF00415E));

  void changeSeedColor(Color seedColor) {
    emit(seedColor);
  }
}
