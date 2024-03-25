import 'package:flutter/material.dart';

import '../../config/constant/sizes.dart';

class OutlineButton extends StatelessWidget {
  final VoidCallback? press;
  final String name;
  final Color? color;
  final double? height;
  final double? width;
  final double? radius;
  final bool? active;

  const OutlineButton({
    super.key,
    this.press,
    required this.name,
    this.color,
    this.height,
    this.width,
    this.radius,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    const double defaultHeight = Sizes.defaultPadding * 2;
    const double defaultWidth = double.maxFinite;

    return SizedBox(
      width: width ?? defaultWidth,
      height: height ?? defaultHeight,
      child: ElevatedButton(
        onPressed: (active ?? true) ? press : () => {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color != null
              ? (active ?? true)
                  ? color
                  : color!.withOpacity(.2)
              : (active ?? true)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? Sizes.smallBorderRaduis,
            ),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: (active ?? true)
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).colorScheme.onBackground.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
