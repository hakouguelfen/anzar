import 'package:flutter/material.dart';

import '../constant/palette.dart';
import '../ui.dart';

class DarkTheme {
  static ColorScheme colorScheme() => const ColorScheme.dark(
        brightness: Brightness.light,
        primary: Palette.primaryLightColor,
        secondary: Palette.secondaryLightColor,
        error: Palette.errorColor,
      );

  static AppBarTheme appBarTheme() => const AppBarTheme(
        backgroundColor: Palette.black2,
        foregroundColor: Palette.textLightColor,
        elevation: 0,
      );

  static InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
        enabledBorder: UI.containerBorder(Palette.white1.withOpacity(0.2)),
        focusedBorder: UI.containerBorder(Palette.secondaryColor),
        errorBorder: UI.containerBorder(Palette.errorColor),
        focusedErrorBorder: UI.containerBorder(Palette.errorColor),
        fillColor: Colors.transparent,
        filled: true,
        isDense: true,
        isCollapsed: true,
      );
}
