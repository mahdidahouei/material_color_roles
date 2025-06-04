import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_color_roles/bloc/theme_cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Color getOnColor(Color color) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    Color onColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    return onColor;
    // return Color.fromARGB(
    //   (color.a * 255.0).round(),
    //   255 - (color.r * 255.0).round(),
    //   255 - (color.g * 255.0).round(),
    //   255 - (color.b * 255.0).round(),
    // );
  }

  String getHexStr(Color color) =>
      color.toARGB32().toRadixString(16).padLeft(8, "0").toUpperCase();

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: 'Hello, clipboard!'));
  }

  Future<void> copyColorHex(Color color) async {
    final hex = getHexStr(color);
    await copyToClipboard(hex);
    Fluttertoast.showToast(msg: "Copied \"$hex\"");
  }

  Widget _buildColorRoleItem({
    required String name,
    required Color color,
    Color? onColor,
  }) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () async {
            await copyColorHex(color);
          },
          child: Container(
            color: color,
            width: double.infinity,
            height: 160.0,
            padding: const EdgeInsets.all(24.0),
            alignment: AlignmentDirectional.centerStart,
            child: SelectableText(
              "$name\n#${getHexStr(color)}",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: onColor ?? getOnColor(color),
              ),
            ),
          ),
        ),
        if (onColor != null)
          GestureDetector(
            onLongPress: () async {
              await copyColorHex(color);
            },
            child: Container(
              color: onColor,
              width: double.infinity,
              height: 124.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: SelectableText(
                "On $name\n#${getHexStr(onColor)}",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildColorRoles(ThemeData themeData) {
    return Column(
      children: [
        _buildColorRoleItem(
          name: "Primary",
          color: themeData.colorScheme.primary,
          onColor: themeData.colorScheme.onPrimary,
        ),

        _buildColorRoleItem(
          name: "Secondary",
          color: themeData.colorScheme.secondary,
          onColor: themeData.colorScheme.onSecondary,
        ),
        _buildColorRoleItem(
          name: "Tertiary",
          color: themeData.colorScheme.tertiary,
          onColor: themeData.colorScheme.onTertiary,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Primary Container",
          color: themeData.colorScheme.primaryContainer,
          onColor: themeData.colorScheme.onPrimaryContainer,
        ),
        _buildColorRoleItem(
          name: "Secondary Container",
          color: themeData.colorScheme.secondaryContainer,
          onColor: themeData.colorScheme.onSecondaryContainer,
        ),
        _buildColorRoleItem(
          name: "Tertiary Container",
          color: themeData.colorScheme.tertiaryContainer,
          onColor: themeData.colorScheme.onTertiaryContainer,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Error",
          color: themeData.colorScheme.error,
          onColor: themeData.colorScheme.onError,
        ),
        _buildColorRoleItem(
          name: "Error Container",
          color: themeData.colorScheme.errorContainer,
          onColor: themeData.colorScheme.onErrorContainer,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Primary Fixed",
          color: themeData.colorScheme.primaryFixed,
        ),
        _buildColorRoleItem(
          name: "Primary Fixed Dim",
          color: themeData.colorScheme.primaryFixedDim,
        ),
        _buildColorRoleItem(
          name: "On Primary Fixed",
          color: themeData.colorScheme.onPrimaryFixed,
        ),
        _buildColorRoleItem(
          name: "On Primary Fixed Variant",
          color: themeData.colorScheme.onPrimaryFixedVariant,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Secondary Fixed",
          color: themeData.colorScheme.secondaryFixed,
        ),
        _buildColorRoleItem(
          name: "Secondary Fixed Dim",
          color: themeData.colorScheme.secondaryFixedDim,
        ),
        _buildColorRoleItem(
          name: "On Secondary Fixed",
          color: themeData.colorScheme.onSecondaryFixed,
        ),
        _buildColorRoleItem(
          name: "On Secondary Fixed Variant",
          color: themeData.colorScheme.onSecondaryFixedVariant,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Tertiary Fixed",
          color: themeData.colorScheme.tertiaryFixed,
        ),
        _buildColorRoleItem(
          name: "Tertiary Fixed Dim",
          color: themeData.colorScheme.tertiaryFixedDim,
        ),
        _buildColorRoleItem(
          name: "On Tertiary Fixed",
          color: themeData.colorScheme.onTertiaryFixed,
        ),
        _buildColorRoleItem(
          name: "On Tertiary Fixed Variant",
          color: themeData.colorScheme.onTertiaryFixedVariant,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Surface Dim",
          color: themeData.colorScheme.surfaceDim,
        ),
        _buildColorRoleItem(
          name: "Surface",
          color: themeData.colorScheme.surface,
        ),
        _buildColorRoleItem(
          name: "Surface Bright",
          color: themeData.colorScheme.surfaceBright,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Surface Container Lowest",
          color: themeData.colorScheme.surfaceContainerLowest,
        ),
        _buildColorRoleItem(
          name: "Surface Container Low",
          color: themeData.colorScheme.surfaceContainerLow,
        ),
        _buildColorRoleItem(
          name: "Surface Container",
          color: themeData.colorScheme.surfaceContainer,
        ),
        _buildColorRoleItem(
          name: "Surface Container High",
          color: themeData.colorScheme.surfaceContainerHigh,
        ),
        _buildColorRoleItem(
          name: "Surface Container Highest",
          color: themeData.colorScheme.surfaceContainerHighest,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "On Surface",
          color: themeData.colorScheme.onSurface,
        ),
        _buildColorRoleItem(
          name: "On Surface Variant",
          color: themeData.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Outline",
          color: themeData.colorScheme.outline,
        ),
        _buildColorRoleItem(
          name: "Outline Variant",
          color: themeData.colorScheme.outlineVariant,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Inverse Surface",
          color: themeData.colorScheme.inverseSurface,
          onColor: themeData.colorScheme.onInverseSurface,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(
          name: "Inverse Primary",
          color: themeData.colorScheme.inversePrimary,
        ),
        const SizedBox(height: 8.0),
        _buildColorRoleItem(name: "Scrim", color: themeData.colorScheme.scrim),
        _buildColorRoleItem(
          name: "Shadow",
          color: themeData.colorScheme.shadow,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    const splitWidth = 770.0;
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final topPadding = MediaQuery.paddingOf(context).top;
    final isBigEnoughToSplit = screenWidth > splitWidth;

    final lightColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: themeCubit.state.seedColor,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: themeCubit.state.seedColor,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + topPadding),
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: isBigEnoughToSplit
                    ? lightColorScheme.surface
                    : themeData.colorScheme.surface,
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: topPadding,
                    start: 16.0,
                    end: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Light color roles",
                        style: themeData.textTheme.titleLarge!.apply(
                          color: isBigEnoughToSplit
                              ? lightColorScheme.onSurface
                              : null,
                        ),
                      ),

                      if (!isBigEnoughToSplit)
                        Row(
                          children: [
                            Text("Dark theme "),
                            Switch(
                              value:
                                  themeCubit.state.brightness ==
                                  Brightness.dark,
                              onChanged: (value) {
                                themeCubit.changeSeedColor(
                                  brightness: value
                                      ? Brightness.dark
                                      : Brightness.light,
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (isBigEnoughToSplit) ...[
              SizedBox(width: 4.0),
              Expanded(
                child: Container(
                  color: Colors.black,
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: topPadding,
                      start: 16.0,
                      end: 16.0,
                    ),
                    child: Text(
                      "Dark color roles",
                      style: themeData.textTheme.titleLarge!.apply(
                        color: darkColorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await launchUrl(
                Uri.https("mahdidahouei.com"),
                webOnlyWindowName: '_blank',
              );
            },
            tooltip: "Visit my personal website",
            child: const Icon(Icons.person),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  Color pickedColor = themeCubit.state.seedColor;
                  return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: themeCubit.state.seedColor,
                        enableAlpha: true,
                        hexInputBar: true,
                        onColorChanged: (color) {
                          pickedColor = color;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          themeCubit.changeSeedColor(seedColor: pickedColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.color_lens),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: isBigEnoughToSplit
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      color: lightColorScheme.surface,
                      child: _buildColorRoles(
                        ThemeData(
                          brightness: Brightness.light,
                          colorScheme: lightColorScheme,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Container(
                      color: darkColorScheme.surface,
                      child: _buildColorRoles(
                        ThemeData(
                          brightness: Brightness.dark,
                          colorScheme: darkColorScheme,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _buildColorRoles(themeData),
      ),
    );
  }
}
