import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'package:priceprediction/config/sized_box.dart';
import 'package:priceprediction/controller/register_controller.dart';
import 'package:priceprediction/view/auth/login_screen.dart';
import 'package:priceprediction/widget/custom_button.dart';
import 'package:priceprediction/widget/custom_textfield.dart';

import '../../widget/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 30.h,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.west, color: AppColors.black,size: 16.h,),
                    onPressed: () {
                      Get.back();
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
                  CustomText(
                    textColor: AppColors.black,
                    fontSize: 21.sp,
                    title: "Registration",
                    maxLines: 2,
                    textStyle: GoogleFonts.montserrat(),
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  AppSizedBox.space10h,
                  CustomText(
                    textColor: AppColors.black,
                    fontSize: 15.sp,
                    title: "Welcome Please enter your information to create an account",
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  AppSizedBox.space10h,
                  CustomTextField(
                    controller: _registerController.usernameController,
                    labelText: 'Username',
                    prefixIcon: Icons.person,
                  ),
                  AppSizedBox.space10h,
                  CustomTextField(
                    controller: _registerController.emailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email_outlined,
                  ),
                  AppSizedBox.space10h,
                  CustomTextField(
                    controller: _registerController.passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.password,
                  ),
                  AppSizedBox.space10h,
                  CustomTextField(
                    controller: _registerController.confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: Icons.password,
                  ),
                  AppSizedBox.space30h,
                  Obx(
                        () => CustomButton(
                      haveBgColor: true,
                      btnTitle: "Register",
                      btnTitleColor: AppColors.white,
                      bgColor: AppColors.primary,
                      borderRadius: 45.r,
                      height: 45.h,
                      onTap: _registerController.isLoading.value ? null : _registerController.register,
                      child: _registerController.isLoading.value
                          ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(color: Colors.white,),
                      )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: TextButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              child: CustomText(
                title: 'Already have an Account? ',
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