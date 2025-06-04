import 'package:flutter/material.dart';
import 'package:material_color_roles/pages/main_page.dart';

class ThemesApp extends StatelessWidget {
  const ThemesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {"/": (context) => MainPage()});
  }
}
