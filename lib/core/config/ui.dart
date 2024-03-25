import 'package:flutter/material.dart';

import 'constant/palette.dart';
import 'constant/sizes.dart';

class UI {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Palette.primaryColor.withOpacity(0.5),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(Sizes.smallPadding),
  );

  static OutlineInputBorder containerBorder(color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: const BorderRadius.all(
        Radius.circular(Sizes.smallBorderRaduis),
      ),
    );
  }

  static BoxDecoration boxDecoration(
    Color color,
    double opacity, {
    double radius = Sizes.smallBorderRaduis,
  }) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
