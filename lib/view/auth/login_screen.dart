import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'package:priceprediction/config/sized_box.dart';
import 'package:priceprediction/controller/login_controller.dart';
import 'package:priceprediction/view/auth/registeration_screen.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth_bg.png", // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 30.h, // Adjust top padding as needed
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.west, color: AppColors.black,size: 16.h,),
                    onPressed: () {
                      Get.back(); // Navigate back
                    },
                  ),
                  CustomText(
                    title: 'Back',
                    fontSize: 14.sp,
                    textColor: AppColors.black,
                  ),
                ],
              )
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textColor: AppColors.black,
                        fontSize: 21.sp,
                        title: "Login",
                        maxLines: 2,
                        textStyle: GoogleFonts.montserrat(),
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      AppSizedBox.space10h,
                      CustomText(
                        textColor: AppColors.black,
                        fontSize: 15.sp,
                        title: "Welcome Back Please enter your credentials to login",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      AppSizedBox.space10h,
                      CustomTextField(
                        controller: _loginController.emailController,
                        labelText: 'Email',
                        prefixIcon: Icons.email_outlined,
                      ),
                      AppSizedBox.space10h,
                      CustomTextField(
                        controller: _loginController.passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        prefixIcon: Icons.password,
                      ),
                      AppSizedBox.space30h,
                      Obx(
                            () => CustomButton(
                          haveBgColor: true,
                          btnTitle: "Login",
                          btnTitleColor: AppColors.white,
                          bgColor: AppColors.primary,
                          borderRadius: 45.r,
                          height: 45.h,
                          onTap: _loginController.isLoading.value ? null : _loginController.login,
                          child: _loginController.isLoading.value
                              ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(color: Colors.white,),
                          )
                              : null,
                        ),
                      ),
                      AppSizedBox.space20h,
                    ],
                  ),
                ],
              ),
            ),
          ),
          // New User Button at the Bottom
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: TextButton(
              onPressed: () {
                Get.to(() => RegisterScreen()); // Navigate to registration screen
              },
              child: CustomText(
                title: 'New user? Register here',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}