import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:priceprediction/config/app_colors.dart';
import 'package:priceprediction/view/home/dashboard.dart';
import '../../controller/dashboard_controller.dart'; // Import DashboardController

class RegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Warning",
        "Passwords do not match.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (usernameController.text.contains(RegExp(r'[0-9]'))) {
      Get.snackbar(
        "Warning",
        "Username cannot contain numbers.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        "Warning",
        "Invalid email format.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoading.value = false;
      // Get the DashboardController instance
      final dashboardController = Get.find<DashboardController>();
      // Set the selected index to 0 (Home screen)
      dashboardController.changeTabIndex(0);
      // Navigate to the Dashboard and remove previous routes
      Get.offAll(() => Dashboard());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage = 'An error occurred.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      Get.snackbar(
        "Warning",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Warning",
        "An unexpected error occurred.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}