import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'package:priceprediction/config/sized_box.dart';
import 'package:priceprediction/view/home/price_prediction_screen.dart';
import 'package:priceprediction/view/home/setting_screen.dart';
import 'package:priceprediction/view/home/user_profile_screen.dart';
import '../../controller/dashboard_controller.dart';
import '../../widget/category_item.dart';
import '../../widget/custom_text.dart';
import '../../widget/property_grid.dart';
import '../onboarding/onboarding_screen.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: Obx(() => _buildBody()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: AppColors.transparent,
      backgroundColor: AppColors.white,
      title: CustomText(
        textColor: AppColors.black,
        fontSize: 16.sp,
        title: "Dashboard",
        maxLines: 2,
        textOverflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
      centerTitle: false,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset(
          "assets/images/menu_open_dark.png",
          color: AppColors.black,
          width: 24.w,
          height: 24.h,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            "assets/images/signout.png",
            color: AppColors.red,
            width: 20.w,
            height: 20.h,
          ),
          onPressed: () async {
            await controller.logout(); // Call the logout function
            Get.offAll(() => OnBoardingScreen()); // Navigate to onboarding and remove previous routes
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    switch (controller.selectedIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return HousePricePredictionScreen();
      case 2:
        return UserProfileScreen();
      case 3:
        return SettingsScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              fontSize: 20.sp,
              title: "Discover",
              fontFamily: 'grenda',
            ),
            CustomText(
              fontSize: 13.sp,
              title: "Explore Our Property Portfolio",
              fontFamily: 'quicksand',
            ),
            AppSizedBox.space10h,
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  child: Image.asset(
                    "assets/images/dashboardHeaderBg.jpg",
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.black.withOpacity(0.4),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 10.w,
                  right: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "New Destinations",
                        fontSize: 14.sp,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        title: "Discover Real Estate",
                        fontSize: 20.sp,
                        fontFamily: 'grenda',
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.white,
                      ),
                      const Divider(thickness: 1.5, color: AppColors.white),
                      CustomText(
                        title: "Explore More Property Listings",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        textColor: AppColors.white,
                        fontFamily: 'quicksand',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSizedBox.space10h,
            _buildCategorySection(),
            AppSizedBox.space15h,
            PropertyGrid(properties: controller.filteredProperties),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              fontSize: 16.sp,
              title: "Categories",
              fontFamily: 'grenda',
            ),
            InkWell(
              onTap: () => controller.selectCategory("All"),
              child: CustomText(
                fontSize: 14.sp,
                title: "View All",
                textColor: AppColors.primary,
                fontFamily: 'quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        AppSizedBox.space15h,
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.availableCategories.length,
            itemBuilder: (context, index) {
              final categoryName = controller.availableCategories[index];
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Obx(() => CategoryItem(
                  categoryName: categoryName,
                  isSelected: controller.selectedCategory == categoryName,
                  onTap: controller.selectCategory,
                )),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        child: GNav(
          backgroundColor: AppColors.white,
          color: AppColors.black,
          tabBackgroundColor: AppColors.primary.withOpacity(0.2),
          gap: 10,
          activeColor: AppColors.primary,
          textStyle: GoogleFonts.quicksand(color: AppColors.black, fontSize: 12),
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.w),
          duration: const Duration(milliseconds: 400),
          selectedIndex: controller.selectedIndex,
          onTabChange: controller.changeTabIndex,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.lineChart,
              text: 'Prediction',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'User',
            ),
            GButton(
              icon: LineIcons.cog,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}