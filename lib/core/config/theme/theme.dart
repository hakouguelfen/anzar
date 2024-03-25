import 'package:flutter/material.dart';

import '../constant/palette.dart';
import 'dark.dart';
import 'light.dart';

ThemeData lightThemeData() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Palette.white1,
    primaryColor: Palette.primaryColor,
    cardColor: Palette.white2,
    appBarTheme: LightTheme.appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: LightTheme.colorScheme(),
    inputDecorationTheme: LightTheme.inputDecorationTheme(),
    listTileTheme: const ListTileThemeData(
      textColor: Palette.textColor,
      dense: true,
    ),
  );
}

ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Palette.primaryColor,
    primaryColor: Palette.white1,
    cardColor: Palette.black3,
    appBarTheme: DarkTheme.appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: DarkTheme.colorScheme(),
    inputDecorationTheme: DarkTheme.inputDecorationTheme(),
    listTileTheme: const ListTileThemeData(
      textColor: Palette.textLightColor,
      dense: true,
    ),
  );
}
