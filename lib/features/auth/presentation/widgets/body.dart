import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/config.dart';
import '../state/auth_state.dart';
import '../state/providers.dart';

class Body extends ConsumerWidget {
  final Widget screen;
  const Body({super.key, required this.screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .1,
            vertical: Sizes.defaultPadding * 2,
          ),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/logo_light.svg',
                semanticsLabel: 'logo light version',
                height: Sizes.largePadding * 2,
              ),
              const SizedBox(height: Sizes.defaultPadding),
              Text(
                "Welcome Back",
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ),
        ref.watch<AuthState>(authNotifierProvider).maybeMap(
              initial: (_) => Container(),
              orElse: () => Container(),
              authenticating: (_) => LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
                minHeight: 3,
              ),
            ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(Sizes.defaultPadding),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Sizes.defaultPadding),
                topLeft: Radius.circular(Sizes.defaultPadding),
              ),
            ),
            child: screen,
          ),
        ),
      ],
    );
  }
}
