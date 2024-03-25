import 'package:flutter/material.dart';

import '../constant/palette.dart';
import '../ui.dart';

class LightTheme {
  static ColorScheme colorScheme() => const ColorScheme.light(
        brightness: Brightness.light,
        primary: Palette.primaryColor,
        secondary: Palette.secondaryColor,
        error: Palette.errorColor,
      );

  static AppBarTheme appBarTheme() => const AppBarTheme(
        backgroundColor: Palette.white1,
        foregroundColor: Palette.textColor,
        elevation: 0,
      );

  static InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
        enabledBorder: UI.containerBorder(Palette.textLightColor),
        focusedBorder: UI.containerBorder(Palette.primaryColor),
        errorBorder: UI.containerBorder(Palette.errorColor),
        focusedErrorBorder: UI.containerBorder(Palette.errorColor),
        filled: true,
        isDense: true,
        isCollapsed: true,
      );
}
