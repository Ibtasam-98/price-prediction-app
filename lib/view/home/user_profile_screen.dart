import 'package:flutter/material.dart'
;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '../../config/app_colors.dart';
import '../../config/sized_box.dart';
import '../../widget/custom_text.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LineIcons.code,
                  size: 25.h,
                  color: AppColors.black,
                ),
                AppSizedBox.space5h,
                CustomText(
                  textColor: AppColors.black,
                  title: "In Progress",
                  fontSize: 15.sp,
                ),
              ],
            ),
          )
      ),
    );
  }
}