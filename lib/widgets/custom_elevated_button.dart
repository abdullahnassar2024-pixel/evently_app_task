 import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? radius;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.verticalPadding,
    this.radius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radius ?? 16),
          side: BorderSide(
            width: 2,
            color:borderColor ?? AppColors.transparentColor,
          )
        ),
        backgroundColor: backgroundColor ?? AppColors.transparentColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
