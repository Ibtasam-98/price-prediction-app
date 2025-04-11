import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final bool haveBgColor;
  final String btnTitle;
  final Color btnTitleColor;
  final Color bgColor;
  final double borderRadius;
  final double height;
  final VoidCallback? onTap;
  final Widget? child;
  final Color? btnBorderColor;
  final double? btnTitleFontSize; // Added optional btnTitleFontSize

  CustomButton({
    required this.haveBgColor,
    required this.btnTitle,
    required this.btnTitleColor,
    required this.bgColor,
    required this.borderRadius,
    required this.height,
    this.onTap,
    this.child,
    this.btnBorderColor,
    this.btnTitleFontSize, // Added optional btnTitleFontSize
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: haveBgColor ? bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: btnBorderColor != null
              ? Border.all(color: btnBorderColor!)
              : null,
        ),
        child: Center(
          child: child != null
              ? child
              : CustomText(
            title: btnTitle,
            fontSize: btnTitleFontSize ?? 15.sp, // Use provided size or default
            textColor: btnTitleColor,
          ),
        ),
      ),
    );
  }
}