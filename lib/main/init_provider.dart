import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/state/providers.dart';
import '../features/settings/presentation/state/providers.dart';

final initProvider = FutureProvider<Unit>((ref) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  final themeNotifier = ref.watch(themeNotifierProvider.notifier);
  final languageNotifier = ref.watch(languageNotifierProvider.notifier);

  Future.microtask(() {
    themeNotifier.getTheme();
    authNotifier.isLoggedIn();
    languageNotifier.getLanguage();
  });

  return unit;
});
