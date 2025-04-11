import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'custom_text.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final Function(String) onTap;

  const CategoryItem({
    super.key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(categoryName),
      child: Container(
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.grey, width: 1.w),
        ),
        child: Center(
          child: CustomText(
            fontSize: 12.sp,
            title: categoryName,
            fontFamily: 'quicksand',
            fontWeight: FontWeight.w500,
            textColor: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}