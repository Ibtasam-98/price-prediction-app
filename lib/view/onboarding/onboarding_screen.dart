import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:priceprediction/view/home/price_prediction_screen.dart';
import '../../config/app_colors.dart';
import '../../config/sized_box.dart';
import '../../controller/onboarding_controller.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../auth/login_screen.dart';
import '../home/dashboard.dart';
class OnBoardingScreen extends StatelessWidget {
  final OnboardingScreenController onBoardingController = Get.put(OnboardingScreenController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Dashboard();
    }

    // If not logged in, show the onboarding screen
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/main_bg.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.black,
                  AppColors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      fontSize: 25.sp,
                      title: "Smart Real Estate Insights",
                      textColor: AppColors.white,
                      textAlign: TextAlign.start,
                      fontFamily: 'grenda',
                      maxLines: 2,
                    ),
                    AppSizedBox.space5h,
                    CustomText(
                      fontSize: 16.sp,
                      title: "Discover accurate home value predictions, empowering your buying and selling decisions.",
                      textAlign: TextAlign.start,
                      textColor: AppColors.white,
                      maxLines: 5,
                    ),
                    AppSizedBox.space30h,
                    Obx(() {
                      return AnimatedOpacity(
                        opacity: onBoardingController.showGuestButton.value ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: SlideTransition(
                          position: onBoardingController.slideAnimation,
                          child: InkWell(
                            hoverColor: AppColors.transparent,
                            highlightColor: AppColors.transparent,
                            splashColor: AppColors.transparent,
                            onTap: () async {
                              Get.to(LoginScreen());
                            },
                            child: CustomButton(
                              haveBgColor: true,
                              btnTitle: "Continue",
                              btnTitleColor: AppColors.white,
                              bgColor: AppColors.transparent,
                              btnBorderColor: AppColors.white,
                              borderRadius: 50.r,
                              height: 45.h,
                            ),
                          ),
                        ),
                      );
                    }),
                    AppSizedBox.space25h,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}