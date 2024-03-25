import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/presentation/views/settings_screen.dart';
import '../state/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const screens = [SettingScreen(), SettingScreen()];

    final int screenIndex = ref.watch(selectedScreenIndex);
    return Scaffold(
      body: screens[screenIndex],
    );
  }
}
