import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_colors.dart';
import '../../config/sized_box.dart';
import '../../widget/custom_text.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Map<String, String> property;

  const PropertyDetailScreen({super.key, required this.property});

  Widget _buildIconButton({
    required IconData iconData,
    required VoidCallback onTap,
    AlignmentGeometry alignment = Alignment.topLeft,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    required BuildContext context, // Add context parameter
  }) {
    return Positioned(
      top: 5.h + MediaQuery.of(context).padding.top,
      left: alignment == Alignment.topLeft ? 16.w : null,
      right: alignment == Alignment.topRight ? 16.w : null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            iconData,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) { // Add context parameter
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              property['image']!,
              width: double.infinity,
              height: 300.h,
              fit: BoxFit.cover,
            ),
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.black.withOpacity(0.6),
                    AppColors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    title: property['name']!,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.white,
                    textAlign: TextAlign.start,
                  ),
                  AppSizedBox.space5h,
                  CustomText(
                    title: "Category: ${property['category']!}",
                    textColor: AppColors.grey.shade300,
                    fontSize: 14.sp,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    final details = [
      {"title": "Details", "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
    ];

    return Padding(
      padding: EdgeInsets.only(top: 300.h + 16.w, left: 16.w, right: 16.w, bottom: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var detail in details)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: detail["title"]!,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  AppSizedBox.space5h,
                  CustomText(
                    fontSize: 14.sp,
                    textAlign: TextAlign.start,
                    title: detail["content"]!,
                  ),
                  AppSizedBox.space15h,
                ],
              ),
            // You can add more detail sections here if needed without repeating the structure
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          _buildImageSection(context), // Pass context here
          _buildIconButton(
            iconData: Icons.west,
            onTap: () => Navigator.pop(context),
            alignment: Alignment.topLeft,
            context: context, // Pass context here
          ),
          _buildIconButton(
            iconData: Icons.favorite_border,
            onTap: () => print("Favorite button pressed"),
            alignment: Alignment.topRight,
            context: context, // Pass context here
          ),
          _buildDetailsSection(),
        ],
      ),
    );
  }
}