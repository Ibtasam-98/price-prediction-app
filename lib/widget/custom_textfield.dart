import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priceprediction/config/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final IconData? prefixIcon; // Optional prefix icon

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.quicksand(),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon,size: 14.h,) : null, // Add prefix icon if provided
        hintStyle: GoogleFonts.quicksand(),
        labelText: labelText,
        labelStyle: GoogleFonts.quicksand(fontSize: 12.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.4)),
        ),
      ),
      obscureText: obscureText,
    );
  }
}