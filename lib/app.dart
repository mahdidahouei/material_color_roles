import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_color_roles/bloc/theme_cubit/theme_cubit.dart';
import 'package:material_color_roles/pages/main_page.dart';

class ThemesApp extends StatefulWidget {
  const ThemesApp({super.key});

  @override
  State<ThemesApp> createState() => _ThemesAppState();
}

class _ThemesAppState extends State<ThemesApp> {
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = ThemeCubit();
  }

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: _themeCubit,
      builder: (context, state) {
        return BlocProvider.value(
          value: _themeCubit,
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                brightness: state.brightness,
                seedColor: state.seedColor,
              ),
              filledButtonTheme: FilledButtonThemeData(style: ButtonStyle()),
            ),
            routes: {"/": (context) => MainPage()},
          ),
        );
      },
    );
  }
}
