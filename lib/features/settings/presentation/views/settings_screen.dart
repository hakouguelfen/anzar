import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/config.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/state/providers.dart';
import '../state/language_state.dart';
import '../state/providers.dart';
import '../state/theme_state.dart';
import '../widgets/custom_select_button.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightThemeText = tr("lightTheme");
    final darkThemeText = tr("darkTheme");

    final arabicText = tr("arabic");
    final englishText = tr("english");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultPadding),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Sizes.defaultPadding),
                width: double.maxFinite,
                height: 200,
                child: SvgPicture.asset(
                  'assets/images/logo_light.svg',
                  semanticsLabel: 'logo light version',
                  height: Sizes.defaultPadding,
                ),
              ),
              const SizedBox(height: Sizes.defaultPadding),
              CustomSelectButton(
                select: (val) {
                  ref
                      .read(languageNotifierProvider.notifier)
                      .setLanguage(val == arabicText ? 'ar' : 'en');
                },
                items: [arabicText, englishText],
                icon: Icons.language_rounded,
                initText:
                    ref.watch<LanguageState>(languageNotifierProvider).maybeMap(
                          initial: (_) => arabicText,
                          orElse: () => arabicText,
                          loaded: (data) => data.locale.languageCode == 'ar'
                              ? arabicText
                              : englishText,
                        ),
              ),
              const SizedBox(height: Sizes.defaultPadding),
              CustomSelectButton(
                select: (val) {
                  ref
                      .read(themeNotifierProvider.notifier)
                      .setTheme(val == lightThemeText ? 'light' : 'dark');
                },
                items: [lightThemeText, darkThemeText],
                icon: Icons.sunny,
                initText: ref.watch<ThemeState>(themeNotifierProvider).maybeMap(
                      initial: (_) => lightThemeText,
                      orElse: () => lightThemeText,
                      loaded: (data) => data.themeData == lightThemeData()
                          ? lightThemeText
                          : darkThemeText,
                    ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(Sizes.defaultPadding),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: MainButton(
          press: () {
            ref.read(authNotifierProvider.notifier).logout();
          },
          name: tr("logout"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
