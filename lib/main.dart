import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/config/theme/theme.dart';
import 'core/routes/router.dart';
import 'features/auth/presentation/state/auth_state.dart';
import 'features/auth/presentation/state/providers.dart';
import 'features/settings/presentation/state/language_state.dart';
import 'features/settings/presentation/state/providers.dart';
import 'features/settings/presentation/state/theme_state.dart';
import 'main/init_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'lib/core/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(child: MainApp()),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(initProvider);

    ref.listen<AuthState>(
      authNotifierProvider,
      (_, state) {
        state.maybeMap(
          orElse: () {},
          authenticated: (_) => context.goNamed('home'),
          unauthenticated: (_) => context.goNamed('welcome'),
          signedOut: (_) => context.goNamed('welcome'),
        );
      },
    );

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      routerConfig: goRouter,
      locale: ref.watch<LanguageState>(languageNotifierProvider).maybeMap(
            initial: (_) => const Locale("en"),
            orElse: () => const Locale("en"),
            loaded: (data) => data.locale,
          ),
      theme: ref.watch<ThemeState>(themeNotifierProvider).maybeMap(
            orElse: () => lightThemeData(),
            darkTheme: (_) => darkThemeData(),
            lightTheme: (_) => lightThemeData(),
          ),
      title: 'anzar',
    );
  }
}
