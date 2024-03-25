import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final Function(String) onChanged;
  final FormFieldValidator<String>? validator;
  final String? value;

  const CustomPasswordField({
    super.key,
    required this.onChanged,
    this.validator,
    this.value,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context);

    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      obscureText: visible,
      initialValue: widget.value,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: themeColor.iconTheme.color!.withOpacity(.5),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            visible = !visible;
            setState(() {});
          },
          icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
          color: themeColor.iconTheme.color!.withOpacity(.5),
        ),
        labelText: tr("password"),
        labelStyle: themeColor.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
