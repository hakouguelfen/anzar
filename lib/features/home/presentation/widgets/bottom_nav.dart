import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/providers.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int screenIndex = ref.watch(selectedScreenIndex);

    List<IconData> unselectedIconList = [
      Icons.business,
    ];

    List<IconData> selectedIconList = [
      Icons.business,
    ];

    List<String> lables = ["setting"];
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: (index) {
        ref.read(selectedScreenIndex.notifier).update((state) => index);
      },
      destinations: unselectedIconList
          .map(
            (e) => NavigationDestination(
              icon: Icon(e),
              selectedIcon:
                  Icon(selectedIconList[unselectedIconList.indexOf(e)]),
              label: lables[unselectedIconList.indexOf(e)],
            ),
          )
          .toList(),
    );
  }
}
