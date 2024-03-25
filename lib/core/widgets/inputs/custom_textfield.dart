import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.controller,
    this.keyboardType,
    this.label,
    this.icon,
    this.suffixIcon,
    this.suffixPress,
    this.value,
    this.validator,
    this.obscureText = false,
    this.readonly = false,
    this.autoFocus,
  });
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? value;
  final String? label;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? suffixPress;
  final bool obscureText;
  final bool readonly;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      keyboardType: keyboardType,
      initialValue: value,
      obscureText: obscureText,
      readOnly: readonly,
      textInputAction: TextInputAction.next,
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: themeColor.iconTheme.color!.withOpacity(.5),
              ),
        labelText: label,
        labelStyle: themeColor.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
