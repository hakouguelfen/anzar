import 'package:flutter/material.dart';

import '../../../../core/config/config.dart';
import '../../../../core/widgets/widgets.dart';

class HomeScreenLoading extends StatelessWidget {
  const HomeScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultPadding),
          child: buildSkelton(),
        ),
      ),
    );
  }

  Skelton buildSkelton() {
    return const Skelton(
      width: double.maxFinite,
      height: 150,
      child: Row(
        children: [
          Skelton(width: 100),
          SizedBox(width: Sizes.defaultPadding * 0.4),
          Expanded(
            child: Column(
              children: [
                Skelton(height: 30),
                SizedBox(height: Sizes.defaultPadding * 0.4),
                Expanded(child: Skelton()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
