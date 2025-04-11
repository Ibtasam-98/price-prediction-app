import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'package:priceprediction/config/sized_box.dart';
import 'package:priceprediction/view/home/property_detail_screen.dart';
import '../../widget/custom_text.dart';
import '../controller/dashboard_controller.dart';

class PropertyGrid extends GetView<DashboardController> {
  final List<Map<String, String>> properties;

  const PropertyGrid({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _calculateGridHeight(properties.length, 2, context),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.2),
                      spreadRadius: 3.r,
                      blurRadius: 7.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => controller.openPropertyDetail(property),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: (MediaQuery.of(context).size.width / 2) * 0.75,
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.r),
                            child: Image.asset(
                              property['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: property['name']!,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'grenda',
                              textColor: AppColors.primary,
                            ),
                            CustomText(
                              title: property['category']!,
                              fontSize: 12.sp,
                              textColor: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 12),
                      SizedBox(width: 2.w),
                      const CustomText(
                        title: "4.5",
                        fontSize: 10,
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _calculateGridHeight(int itemCount, int crossAxisCount, BuildContext context) {
    if (itemCount == 0) {
      return 0;
    }
    final double screenWidth = MediaQuery.of(context).size.width - 30.w; // Adjust for padding
    final double itemWidth = screenWidth / crossAxisCount;
    final double imageHeight = itemWidth * 0.75; // Adjusted image height
    final double textHeight = 50.h; // Approximate height for the text below the image
    final double itemTotalHeight = imageHeight + 4.w * 2 + 8.w * 2 + textHeight; // Image padding + text padding + text
    final int rows = (itemCount / crossAxisCount).ceil();
    return rows * itemTotalHeight + (rows > 0 ? (rows - 1) * 10.h : 0); // Total height with spacing
  }
}

