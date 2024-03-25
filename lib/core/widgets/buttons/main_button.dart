import 'package:flutter/material.dart';

import '../../config/constant/sizes.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? press;
  final String name;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? radius;
  final bool? active;

  const MainButton({
    super.key,
    this.press,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.radius,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    const double defaultHeight = Sizes.largePadding;
    const double defaultWidth = double.maxFinite;

    return SizedBox(
      width: width ?? defaultWidth,
      height: height ?? defaultHeight,
      child: ElevatedButton(
        onPressed: (active ?? true) ? press : () => {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? Sizes.smallBorderRaduis,
            ),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: textColor ?? Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
