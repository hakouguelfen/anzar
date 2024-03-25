import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/base_client_provider.dart';
import '../../data/datasources/settings_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import 'language_notifier.dart';
import 'language_state.dart';
import 'theme_notifier.dart';
import 'theme_state.dart';

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSourceImpl>(
  (ref) => SettingsLocalDataSourceImpl(
    localStorage: ref.watch(localStorageProvider),
  ),
);

final settingsRepositoryProvider = Provider<SettingsRepositoryImpl>(
  (ref) => SettingsRepositoryImpl(
    settingsLocalDataSource: ref.watch(settingsLocalDataSourceProvider),
  ),
);

final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>(
  (ref) => LanguageNotifier(
    ref.watch(settingsRepositoryProvider),
  ),
);

// Theme notifier
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(
    ref.watch(settingsRepositoryProvider),
  ),
);
