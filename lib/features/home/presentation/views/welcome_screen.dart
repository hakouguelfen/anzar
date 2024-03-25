import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/config.dart';
import '../../../../core/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: theme.scaffoldBackgroundColor),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_light.svg',
                    semanticsLabel: 'logo light version',
                    height: Sizes.largePadding * 2,
                  ),
                  Text(
                    "ANZAR",
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(Sizes.largePadding),
              child: Text(
                "START A NEW\nAPP EXPERIENCE",
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Sizes.largePadding),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Sizes.largePadding * 2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get anzar and Start\nBuilding NOW",
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: theme.scaffoldBackgroundColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: Sizes.defaultPadding * 2),
                  MainButton(
                    name: "SIGN IN",
                    backgroundColor: theme.scaffoldBackgroundColor,
                    textColor: theme.primaryColor,
                    press: () => context.pushNamed('login'),
                  ),
                  const SizedBox(height: Sizes.defaultPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => context.pushNamed('register'),
                      label: Text(
                        "Create account",
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: theme.scaffoldBackgroundColor,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_right,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
