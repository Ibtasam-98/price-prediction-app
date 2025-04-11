import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/app_colors.dart';
import 'custom_text.dart';



class InputContainer extends StatelessWidget {
  final String label;
  final Widget child;
  final int index;

  InputContainer({
    required this.label,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: index % 2 == 0
            ? AppColors.primary.withOpacity(0.4)
            : AppColors.primary.withOpacity(0.1),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, bottom: 5.h, left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: label,
              fontSize: 13.sp,
              textColor: AppColors.primary,
              capitalize: true,
            ),
            child,
          ],
        ),
      ),
    );
  }
}