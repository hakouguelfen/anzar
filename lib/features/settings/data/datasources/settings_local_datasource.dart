import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/config/config.dart';

abstract class SettingsLocalDataSource {
  Future<Locale> getLanguage();
  Future<ThemeData> getTheme();
  Future<Locale> setLanguage(String locale);
  Future<ThemeData> setTheme(String theme);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final FlutterSecureStorage localStorage;
  SettingsLocalDataSourceImpl({required this.localStorage});

  @override
  Future<Locale> getLanguage() async {
    String? locale = await localStorage.read(key: 'locale');

    if (locale == null) {
      return setLanguage('en');
    }

    return Locale(locale);
  }

  @override
  Future<ThemeData> getTheme() async {
    String? theme = await localStorage.read(key: 'theme');

    if (theme == null) {
      return setTheme('light');
    }

    return theme == "dark" ? darkThemeData() : lightThemeData();
  }

  @override
  Future<Locale> setLanguage(String locale) async {
    localStorage.write(key: 'locale', value: locale);
    return Locale(locale);
  }

  @override
  Future<ThemeData> setTheme(String theme) async {
    localStorage.write(key: 'theme', value: theme);

    return theme == "dark" ? darkThemeData() : lightThemeData();
  }
}
