 import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator =  String? Function(String?)?;
class CustomTextField extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final bool? filled;
  final Color? fillColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.radius,
    required this.borderColor,
    this.filled,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: borderColor,
        ),
        focusedBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: borderColor,
        ),
        errorBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: AppColors.redColor,
        ),
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator:validator ,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  OutlineInputBorder _builtDecorationBorder({
    required double radius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
